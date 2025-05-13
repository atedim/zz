#!/bin/bash

# ===============================================================
# Script de Configuracao Dual WAN para Linux
# Este script configura duas interfaces de rede em modo failover 
# ou balanceamento de carga, com suporte a DHCP.
# ===============================================================

# Verifica se o script esta sendo executado como root
if [ "$(id -u)" -ne 0 ]; then
    echo "Este script precisa ser executado como root. Saindo."
    exit 1
fi

# Definir diretorio padrao para scripts e criar se nao existir
SCRIPT_DIR="/etc/scripts/"
if [ ! -d "$SCRIPT_DIR" ]; then
    mkdir -p "$SCRIPT_DIR"
    chmod 755 "$SCRIPT_DIR"
fi

# Verificar se os pacotes necessarios estao instalados
REQUIRED_PKGS=("iproute2" "inetutils-ping" "curl" "dhclient")
MISSING_PKGS=()

# Loop para verificar cada pacote
for PKG in "${REQUIRED_PKGS[@]}"; do
    # Verifica se o pacote esta instalado usando dpkg
    if ! dpkg -l | grep -q "^ii  $PKG "; then
        MISSING_PKGS+=("$PKG")
    fi
done

# Se existem pacotes faltando, perguntar ao usuario se deseja instala-los
if [ ${#MISSING_PKGS[@]} -ne 0 ]; then
    echo "Os seguintes pacotes necessarios nao estao instalados: ${MISSING_PKGS[*]}"
    echo -n "Deseja instalar os pacotes agora? (s/n): "
    read -r INSTALL
    if [[ "$INSTALL" =~ ^[Ss]$ ]]; then
        # Atualizar repositorios e instalar pacotes
        apt update && apt install -y "${MISSING_PKGS[@]}"
        if [ $? -ne 0 ]; then
            echo "Erro ao instalar pacotes. Verifique sua conexao ou repositorios e tente novamente."
            exit 1
        fi
    else
        echo "A instalacao dos pacotes foi ignorada. O script pode nao funcionar corretamente."
    fi
fi

# Funcao para validar endereco IP
validate_ip() {
    local ip=$1
    # Verifica o formato do IP usando expressao regular
    if [[ ! $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        return 1
    fi
    
    # Verifica se cada octeto esta dentro do range valido (0-255)
    IFS='.' read -r -a segments <<< "$ip"
    for segment in "${segments[@]}"; do
        if [[ $segment -gt 255 ]]; then
            return 1
        fi
    done
    
    return 0
}

# Funcao para validar interface de rede
validate_interface() {
    local interface=$1
    # Verifica se a interface existe usando o comando ip
    if ! ip link show "$interface" &>/dev/null; then
        return 1
    fi
    return 0
}

# Banner e inicio da interface com o usuario
echo "========================================================"
echo "Configuracao da Rede com Dual WAN no Linux (com DHCP)"
echo "========================================================"

# Lista interfaces disponiveis para facilitar a escolha do usuario
echo "Interfaces de rede disponiveis:"
ip -br link show | grep -v "lo " | awk '{print "- " $1}'
echo "--------------------------------------------------------"

# Solicita o nome da primeira interface com validacao
while true; do
    echo -n "Digite o nome da primeira interface de rede (WAN1): "
    read -r IFACE1
    if validate_interface "$IFACE1"; then
        break
    else
        echo "Interface $IFACE1 nao encontrada. Por favor, verifique o nome."
    fi
done

# Solicita o nome da segunda interface com validacao
while true; do
    echo -n "Digite o nome da segunda interface de rede (WAN2): "
    read -r IFACE2
    if [ "$IFACE1" = "$IFACE2" ]; then
        echo "Voce nao pode usar a mesma interface. Por favor, escolha outra."
    elif validate_interface "$IFACE2"; then
        break
    else
        echo "Interface $IFACE2 nao encontrada. Por favor, verifique o nome."
    fi
done

# Perguntar sobre o tipo de configuração de cada interface
echo "--------------------------------------------------------"
echo "Configuracao da Interface $IFACE1 (WAN1):"
echo "1 - DHCP (Obter IP automaticamente)"
echo "2 - Estatico (Configurar IP manualmente)"
echo -n "Digite sua escolha (1 ou 2): "
read -r WAN1_CONFIG_TYPE

IP1=""
GW1=""
MASK1=""

if [ "$WAN1_CONFIG_TYPE" == "1" ]; then
    # Configuração DHCP para WAN1
    echo "Configurando WAN1 com DHCP..."
    # Pare qualquer cliente DHCP rodando nesta interface
    dhclient -r "$IFACE1" &>/dev/null
    # Inicie um novo cliente DHCP
    dhclient "$IFACE1"
    
    # Obtenha os valores configurados
    IP1=$(ip addr show "$IFACE1" | grep -oP 'inet \K[\d.]+')
    CIDR1=$(ip addr show "$IFACE1" | grep -oP 'inet \K[\d.]+/\d+')
    GW1=$(ip route show | grep "default.*$IFACE1" | awk '{print $3}')
    
    if [ -z "$IP1" ] || [ -z "$GW1" ]; then
        echo "Erro ao obter configuracao DHCP para $IFACE1. Verifique a conexao."
        exit 1
    fi
    
    echo "Configuracao DHCP obtida para $IFACE1:"
    echo "IP: $IP1"
    echo "Gateway: $GW1"
else
    # Configuração Estática para WAN1
    # Solicita o endereco IP para a primeira interface
    while true; do
        echo -n "Digite o endereco IP da interface $IFACE1 (com mascara, ex: 192.168.1.10/24): "
        read -r IP1_CIDR
        IP1=$(echo "$IP1_CIDR" | cut -d'/' -f1)
        CIDR1="$IP1_CIDR"
        if validate_ip "$IP1"; then
            break
        else
            echo "Endereco IP invalido. Por favor, tente novamente."
        fi
    done

    # Solicita o gateway para a primeira interface
    while true; do
        echo -n "Digite o gateway da interface $IFACE1: "
        read -r GW1
        if validate_ip "$GW1"; then
            break
        else
            echo "Endereco de gateway invalido. Por favor, tente novamente."
        fi
    done
fi

# Configuração para WAN2
echo "--------------------------------------------------------"
echo "Configuracao da Interface $IFACE2 (WAN2):"
echo "1 - DHCP (Obter IP automaticamente)"
echo "2 - Estatico (Configurar IP manualmente)"
echo -n "Digite sua escolha (1 ou 2): "
read -r WAN2_CONFIG_TYPE

IP2=""
GW2=""
MASK2=""

if [ "$WAN2_CONFIG_TYPE" == "1" ]; then
    # Configuração DHCP para WAN2
    echo "Configurando WAN2 com DHCP..."
    # Pare qualquer cliente DHCP rodando nesta interface
    dhclient -r "$IFACE2" &>/dev/null
    # Inicie um novo cliente DHCP
    dhclient "$IFACE2"
    
    # Obtenha os valores configurados
    IP2=$(ip addr show "$IFACE2" | grep -oP 'inet \K[\d.]+')
    CIDR2=$(ip addr show "$IFACE2" | grep -oP 'inet \K[\d.]+/\d+')
    GW2=$(ip route show | grep "default.*$IFACE2" | awk '{print $3}')
    
    if [ -z "$IP2" ] || [ -z "$GW2" ]; then
        echo "Erro ao obter configuracao DHCP para $IFACE2. Verifique a conexao."
        exit 1
    fi
    
    echo "Configuracao DHCP obtida para $IFACE2:"
    echo "IP: $IP2"
    echo "Gateway: $GW2"
else
    # Configuração Estática para WAN2
    # Solicita o endereco IP para a segunda interface
    while true; do
        echo -n "Digite o endereco IP da interface $IFACE2 (com mascara, ex: 192.168.2.10/24): "
        read -r IP2_CIDR
        IP2=$(echo "$IP2_CIDR" | cut -d'/' -f1)
        CIDR2="$IP2_CIDR"
        if validate_ip "$IP2"; then
            break
        else
            echo "Endereco IP invalido. Por favor, tente novamente."
        fi
    done

    # Solicita o gateway para a segunda interface
    while true; do
        echo -n "Digite o gateway da interface $IFACE2: "
        read -r GW2
        if validate_ip "$GW2"; then
            break
        else
            echo "Endereco de gateway invalido. Por favor, tente novamente."
        fi
    done
fi

# Menu para escolher o modo de roteamento
echo "--------------------------------------------------------"
echo "Escolha o modo de roteamento:"
echo "1 - Failover (WAN1 primaria, WAN2 secundaria)"
echo "2 - Balanceamento de carga (50/50)"
echo "3 - Balanceamento personalizado"
echo -n "Digite sua escolha (1, 2 ou 3): "
read -r MODE

# Se o modo escolhido for balanceamento personalizado,
# solicita os pesos para cada interface
WEIGHT1=1
WEIGHT2=1
if [ "$MODE" == "3" ]; then
    echo "Defina os pesos para o balanceamento (valores maiores aumentam a prioridade):"
    while true; do
        echo -n "Peso para WAN1 (1-10): "
        read -r WEIGHT1
        if [[ "$WEIGHT1" =~ ^[1-9]|10$ ]]; then
            break
        else
            echo "Por favor, insira um valor entre 1 e 10."
        fi
    done
    
    while true; do
        echo -n "Peso para WAN2 (1-10): "
        read -r WEIGHT2
        if [[ "$WEIGHT2" =~ ^[1-9]|10$ ]]; then
            break
        else
            echo "Por favor, insira um valor entre 1 e 10."
        fi
    done
fi

# Cria backup das configuracoes atuais
echo "Criando backup das configuracoes de rede atuais..."
TIMESTAMP=$(date +%Y%m%d%H%M%S)
mkdir -p /root/network_backups
ip route show > "/root/network_backups/routes_$TIMESTAMP.bak"
ip rule show > "/root/network_backups/rules_$TIMESTAMP.bak"

# Limpa configuracoes anteriores para evitar conflitos
echo "Limpando configuracoes de rotas existentes..."
ip rule del table link1 2>/dev/null || true
ip rule del table link2 2>/dev/null || true
ip route flush table link1 2>/dev/null || true
ip route flush table link2 2>/dev/null || true

# Cria tabelas de roteamento se nao existirem
if ! grep -q "link1" /etc/iproute2/rt_tables; then
  echo "200 link1" >> /etc/iproute2/rt_tables
fi
if ! grep -q "link2" /etc/iproute2/rt_tables; then
  echo "201 link2" >> /etc/iproute2/rt_tables
fi

# Extrair informações de rede (independente se for DHCP ou estático)
# Use ipcalc apenas se tivermos o CIDR completo, caso contrário tente extrair das informações de rede
if [ "$WAN1_CONFIG_TYPE" == "2" ]; then
    NETWORK1=$(ipcalc "$CIDR1" | grep Network | awk '{print $2}')
else
    # Em DHCP, precisamos descobrir a rede com base nas informações já configuradas
    PREFIX1=$(ip addr show "$IFACE1" | grep -oP 'inet \K[\d.]+/\d+' | cut -d'/' -f2)
    if [ -n "$PREFIX1" ]; then
        NETWORK1=$(ip route | grep "$IFACE1" | grep -v default | head -n 1 | awk '{print $1}')
    else
        echo "Não foi possível determinar a rede para $IFACE1. Usando configuração padrão."
        NETWORK1="0.0.0.0/0"
    fi
fi

if [ "$WAN2_CONFIG_TYPE" == "2" ]; then
    NETWORK2=$(ipcalc "$CIDR2" | grep Network | awk '{print $2}')
else
    # Em DHCP, precisamos descobrir a rede com base nas informações já configuradas
    PREFIX2=$(ip addr show "$IFACE2" | grep -oP 'inet \K[\d.]+/\d+' | cut -d'/' -f2)
    if [ -n "$PREFIX2" ]; then
        NETWORK2=$(ip route | grep "$IFACE2" | grep -v default | head -n 1 | awk '{print $1}')
    else
        echo "Não foi possível determinar a rede para $IFACE2. Usando configuração padrão."
        NETWORK2="0.0.0.0/0"
    fi
fi

# Configura tabelas de roteamento para cada interface
echo "Configurando tabelas de roteamento..."
ip route add "$NETWORK1" dev "$IFACE1" src "$IP1" table link1
ip route add default via "$GW1" dev "$IFACE1" table link1
ip route add "$NETWORK2" dev "$IFACE2" src "$IP2" table link2
ip route add default via "$GW2" dev "$IFACE2" table link2

# Adiciona regras de roteamento baseadas na origem
ip rule add from "$IP1" table link1
ip rule add from "$IP2" table link2

# Configura o modo de roteamento escolhido
if [ "$MODE" == "1" ]; then
    echo "Configurando Failover..."
    ip route del default 2>/dev/null || true
    ip route add default via "$GW1" dev "$IFACE1" metric 100
    ip route add default via "$GW2" dev "$IFACE2" metric 200
elif [ "$MODE" == "2" ] || [ "$MODE" == "3" ]; then
    echo "Configurando Balanceamento de Carga..."
    ip route del default 2>/dev/null || true
    ip route add default scope global \
      nexthop via "$GW1" dev "$IFACE1" weight "$WEIGHT1" \
      nexthop via "$GW2" dev "$IFACE2" weight "$WEIGHT2"
else
    echo "Opcao invalida! Configuracao abortada."
    exit 1
fi

# Cria script de monitoramento com suporte a renovação DHCP
echo "Criando script de monitoramento..."

cat <<EOF > "${SCRIPT_DIR}network_monitor.sh"
#!/bin/bash

# Script de monitoramento de conexoes Dual WAN com suporte a DHCP
# Configurado automaticamente pelo script de setup Dual WAN
# Este script verifica constantemente a conectividade das interfaces
# e ajusta as rotas conforme necessario

# Variaveis de configuracao
IFACE1="$IFACE1"
IFACE2="$IFACE2"
GW1="$GW1"
GW2="$GW2"
IP1="$IP1"
IP2="$IP2"
MODE="$MODE"
WEIGHT1="$WEIGHT1"
WEIGHT2="$WEIGHT2"
WAN1_CONFIG_TYPE="$WAN1_CONFIG_TYPE"
WAN2_CONFIG_TYPE="$WAN2_CONFIG_TYPE"

# Servidores DNS para teste de conectividade
TEST_HOSTS=("8.8.8.8" "1.1.1.1")
LOG_FILE="/var/log/dual_wan_monitor.log"

# Funcao para verificar conectividade de uma interface
check_connectivity() {
    local gateway="\$1"
    local success=0
    
    # Tenta ping no gateway
    if ping -c 2 -W 2 "\$gateway" &>/dev/null; then
        return 0
    fi
    
    # Se o ping falhar, tenta os servidores DNS
    for host in "\${TEST_HOSTS[@]}"; do
        if ping -c 2 -W 2 "\$host" &>/dev/null; then
            return 0
        fi
    done
    
    # Se nenhum teste for bem-sucedido, tenta um teste HTTP
    if curl -s --connect-timeout 5 "http://www.google.com" &>/dev/null; then
        return 0
    fi
    
    return 1
}

# Funcao para renovar DHCP e atualizar configuracoes
renew_dhcp() {
    local interface="\$1"
    local table="\$2"
    local config_type="\$3"
    
    if [ "\$config_type" == "1" ]; then
        log_event "Renovando DHCP para interface \$interface..."
        dhclient -r "\$interface" &>/dev/null
        dhclient "\$interface"
        
        # Obtenha novos valores
        local new_ip=\$(ip addr show "\$interface" | grep -oP 'inet \K[\d.]+')
        local new_gateway=\$(ip route show | grep "default.*\$interface" | awk '{print \$3}')
        local network=\$(ip route | grep "\$interface" | grep -v default | head -n 1 | awk '{print \$1}')
        
        if [ -n "\$new_ip" ] && [ -n "\$new_gateway" ]; then
            # Atualiza as configuracoes
            ip route flush table "\$table" 2>/dev/null || true
            ip rule del from "\$IP1" table "\$table" 2>/dev/null || true
            
            # Adiciona novas rotas
            ip route add "\$network" dev "\$interface" src "\$new_ip" table "\$table"
            ip route add default via "\$new_gateway" dev "\$interface" table "\$table"
            ip rule add from "\$new_ip" table "\$table"
            
            # Atualiza variáveis
            if [ "\$interface" == "\$IFACE1" ]; then
                IP1="\$new_ip"
                GW1="\$new_gateway"
                log_event "Novos valores para WAN1: IP=\$IP1, GW=\$GW1"
            else
                IP2="\$new_ip"
                GW2="\$new_gateway"
                log_event "Novos valores para WAN2: IP=\$IP2, GW=\$GW2"
            fi
            
            # Atualiza rota padrão
            update_routes
            
            return 0
        else
            log_event "Falha ao renovar DHCP para \$interface"
            return 1
        fi
    fi
    return 0
}

# Funcao para atualizar rotas com base no modo e status das interfaces
update_routes() {
    if [ "\$MODE" == "1" ]; then
        # Modo Failover
        if [ "\$WAN1_STATUS" == "up" ]; then
            ip route replace default via "\$GW1" dev "\$IFACE1" metric 100
            ip route replace default via "\$GW2" dev "\$IFACE2" metric 200
        elif [ "\$WAN2_STATUS" == "up" ]; then
            ip route replace default via "\$GW2" dev "\$IFACE2" metric 100
            log_event "Failover ativado: trafego redirecionado para WAN2"
        else
            log_event "ALERTA: Ambas as conexoes WAN estao inacessiveis!"
        fi
    elif [ "\$MODE" == "2" ] || [ "\$MODE" == "3" ]; then
        # Modo Balanceamento
        if [ "\$WAN1_STATUS" == "up" ] && [ "\$WAN2_STATUS" == "up" ]; then
            ip route replace default scope global \
                nexthop via "\$GW1" dev "\$IFACE1" weight "\$WEIGHT1" \
                nexthop via "\$GW2" dev "\$IFACE2" weight "\$WEIGHT2"
        elif [ "\$WAN1_STATUS" == "up" ]; then
            ip route replace default via "\$GW1" dev "\$IFACE1"
            log_event "Balanceamento desativado: usando apenas WAN1"
        elif [ "\$WAN2_STATUS" == "up" ]; then
            ip route replace default via "\$GW2" dev "\$IFACE2"
            log_event "Balanceamento desativado: usando apenas WAN2"
        else
            log_event "ALERTA: Ambas as conexoes WAN estao inacessiveis!"
        fi
    fi
}

# Funcao para registrar eventos no arquivo de log
log_event() {
    echo "\$(date '+%Y-%m-%d %H:%M:%S') - \$1" >> "\$LOG_FILE"
    echo "\$(date '+%Y-%m-%d %H:%M:%S') - \$1"
}

# Funcao para notificar mudancas de estado
notify_status() {
    log_event "\$1"
}

# Limpa log se ficar muito grande (mais de 1MB)
if [ -f "\$LOG_FILE" ] && [ \$(stat -c%s "\$LOG_FILE") -gt 1048576 ]; then
    mv "\$LOG_FILE" "\${LOG_FILE}.old"
    touch "\$LOG_FILE"
fi

# Status inicial das interfaces
WAN1_STATUS="unknown"
WAN2_STATUS="unknown"
WAN1_FAILURES=0
WAN2_FAILURES=0
MAX_FAILURES=3  # Número de falhas consecutivas antes de tentar renovar DHCP

log_event "Iniciando monitoramento de Dual WAN com suporte a DHCP"

# Loop principal de monitoramento
while true; do
    # Verificar conectividade de WAN1
    if check_connectivity "\$GW1"; then
        if [ "\$WAN1_STATUS" != "up" ]; then
            WAN1_STATUS="up"
            WAN1_FAILURES=0
            log_event "WAN1 ($IFACE1) esta ONLINE"
        fi
    else
        WAN1_FAILURES=$((WAN1_FAILURES + 1))
        if [ "\$WAN1_STATUS" != "down" ] && [ \$WAN1_FAILURES -ge \$MAX_FAILURES ]; then
            WAN1_STATUS="down"
            log_event "WAN1 ($IFACE1) esta OFFLINE após \$WAN1_FAILURES falhas"
            
            # Tenta renovar DHCP se configurado como tal
            if [ "\$WAN1_CONFIG_TYPE" == "1" ]; then
                log_event "Tentando renovar DHCP para WAN1..."
                if renew_dhcp "\$IFACE1" "link1" "\$WAN1_CONFIG_TYPE"; then
                    WAN1_FAILURES=0
                    log_event "DHCP renovado para WAN1"
                fi
            fi
        fi
    fi
    
    # Verificar conectividade de WAN2
    if check_connectivity "\$GW2"; then
        if [ "\$WAN2_STATUS" != "up" ]; then
            WAN2_STATUS="up"
            WAN2_FAILURES=0
            log_event "WAN2 ($IFACE2) esta ONLINE"
        fi
    else
        WAN2_FAILURES=$((WAN2_FAILURES + 1))
        if [ "\$WAN2_STATUS" != "down" ] && [ \$WAN2_FAILURES -ge \$MAX_FAILURES ]; then
            WAN2_STATUS="down"
            log_event "WAN2 ($IFACE2) esta OFFLINE após \$WAN2_FAILURES falhas"
            
            # Tenta renovar DHCP se configurado como tal
            if [ "\$WAN2_CONFIG_TYPE" == "1" ]; then
                log_event "Tentando renovar DHCP para WAN2..."
                if renew_dhcp "\$IFACE2" "link2" "\$WAN2_CONFIG_TYPE"; then
                    WAN2_FAILURES=0
                    log_event "DHCP renovado para WAN2"
                fi
            fi
        fi
    fi
    
    # Atualizar rotas com base no status das interfaces
    update_routes
    
    # Aguardar antes da proxima verificacao
    sleep 10
done
EOF

# Torna o script de monitoramento executavel
chmod +x "${SCRIPT_DIR}network_monitor.sh"

# Cria servico systemd para o monitoramento
echo "Criando servico systemd para o monitoramento..."
cat <<EOF > /etc/systemd/system/dual-wan-monitor.service
[Unit]
Description=Dual WAN Monitor Service
After=network.target

[Service]
Type=simple
ExecStart=${SCRIPT_DIR}network_monitor.sh
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

# Cria script de configuracao permanente para inicializacao
echo "Criando script de configuracao para inicializacao automatica..."
cat <<EOF > /etc/network/dual_wan_setup.sh
#!/bin/bash

# Script de configuracao Dual WAN para inicializacao automatica
# Configurado em: $(date)
# Este script restaura a configuracao Dual WAN apos reinicializacao

# Verifica e cria tabelas de roteamento
if ! grep -q "link1" /etc/iproute2/rt_tables; then
  echo "200 link1" >> /etc/iproute2/rt_tables
fi
if ! grep -q "link2" /etc/iproute2/rt_tables; then
  echo "201 link2" >> /etc/iproute2/rt_tables
fi

# Configuração das interfaces - respeitando tipo de configuração
WAN1_CONFIG_TYPE="$WAN1_CONFIG_TYPE"
WAN2_CONFIG_TYPE="$WAN2_CONFIG_TYPE"

# Configuração para WAN1
if [ "\$WAN1_CONFIG_TYPE" == "1" ]; then
    # Obter IP via DHCP
    dhclient -r $IFACE1 &>/dev/null
    dhclient $IFACE1
    
    # Extrair informações obtidas
    WAN1_IP=\$(ip addr show $IFACE1 | grep -oP 'inet \K[\d.]+')
    WAN1_GW=\$(ip route show | grep "default.*$IFACE1" | awk '{print \$3}')
    WAN1_NETWORK=\$(ip route | grep "$IFACE1" | grep -v default | head -n 1 | awk '{print \$1}')
else
    # Usar configuração estática
    ip addr add $CIDR1 dev $IFACE1 2>/dev/null || true
    WAN1_IP="$IP1"
    WAN1_GW="$GW1"
    WAN1_NETWORK="$NETWORK1"
fi

# Configuração para WAN2
if [ "\$WAN2_CONFIG_TYPE" == "1" ]; then
    # Obter IP via DHCP
    dhclient -r $IFACE2 &>/dev/null
    dhclient $IFACE2
    
    # Extrair informações obtidas
    WAN2_IP=\$(ip addr show $IFACE2 | grep -oP 'inet \K[\d.]+')
    WAN2_GW=\$(ip route show | grep "default.*$IFACE2" | awk '{print \$3}')
    WAN2_NETWORK=\$(ip route | grep "$IFACE2" | grep -v default | head -n 1 | awk '{print \$1}')
else
    # Usar configuração estática
    ip addr add $CIDR2 dev $IFACE2 2>/dev/null || true
    WAN2_IP="$IP2"
    WAN2_GW="$GW2"
    WAN2_NETWORK="$NETWORK2"
fi

# Ativar interfaces
ip link set $IFACE1 up
ip link set $IFACE2 up

# Configuracao das rotas para cada interface
ip route add \$WAN1_NETWORK dev $IFACE1 src \$WAN1_IP table link1
ip route add default via \$WAN1_GW dev $IFACE1 table link1
ip route add \$WAN2_NETWORK dev $IFACE2 src \$WAN2_IP table link2
ip route add default via \$WAN2_GW dev $IFACE2 table link2

# Regras de roteamento baseado na origem
ip rule add from \$WAN1_IP table link1
ip rule add from \$WAN2_IP table link2

# Configuracao de rota padrao conforme modo selecionado
if [ "$MODE" == "1" ]; then
    # Modo Failover
    ip route add default via \$WAN1_GW dev $IFACE1 metric 100
    ip route add default via \$WAN2_GW dev $IFACE2 metric 200
elif [ "$MODE" == "2" ] || [ "$MODE" == "3" ]; then
    # Modo Balanceamento
    ip route add default scope global \
      nexthop via \$WAN1_GW dev $IFACE1 weight $WEIGHT1 \
      nexthop via \$WAN2_GW dev $IFACE2 weight $WEIGHT2
fi

exit 0
EOF

# Torna o script de inicializacao executavel
chmod +x /etc/network/dual_wan_setup.sh

# Inicia o servico de monitoramento
echo "Iniciando servico de monitoramento..."
systemctl daemon-reload
systemctl enable dual-wan-monitor.service
systemctl start dual-wan-monitor.service

# Exibe a configuracao aplicada
echo "--------------------------------------------------------"
echo "Configuracao aplicada com sucesso!"
echo "Rotas configuradas:"
ip route show
echo "--------------------------------------------------------"
echo "Regras de roteamento:"
ip rule show
echo "--------------------------------------------------------"

# Pergunta se deseja salvar as configuracoes para inicializacao automatica
echo "Deseja salvar as configuracoes para inicializacao automatica? (s/n)"
read -r SAVE
if [[ "$SAVE" =~ ^[Ss]$ ]]; then
    # Verifica o tipo de sistema (Debian/Ubuntu ou outro)
    if [ -f "/etc/network/if-up.d" ] || [ -d "/etc/network/if-up.d" ]; then
        # Debian/Ubuntu usa scripts em if-up.d
        echo "Salvando configuracoes no sistema Debian/Ubuntu..."
        cat <<EOF > /etc/network/if-up.d/dual-wan
#!/bin/bash
/etc/network/dual_wan_setup.sh
exit 0
EOF
        chmod +x /etc/network/if-up.d/dual-wan
    else
        # Metodo generico para outros sistemas
        echo "Salvando configuracoes para inicializacao..."
        if [ -f "/etc/rc.local" ]; then
            # Verifica se ja existe a linha no arquivo
            if ! grep -q "dual_wan_setup.sh" /etc/rc.local; then
                # Insere antes do "exit 0" se existir
                if grep -q "^exit 0" /etc/rc.local; then
                    sed -i '/^exit 0/i /etc/network/dual_wan_setup.sh' /etc/rc.local
                else
                    echo "/etc/network/dual_wan_setup.sh" >> /etc/rc.local
                fi
            fi
        else
            # Cria rc.local se nao existir
            cat <<EOF > /etc/rc.local
#!/bin/bash
/etc/network/dual_wan_setup.sh
exit 0
EOF
            chmod +x /etc/rc.local
        fi
    fi
    
    echo "Configuracoes salvas para inicializacao automatica."
fi

# Mensagem final
echo "==========================================================="
echo "Configuracao Dual WAN concluida com sucesso!"
echo "O script de monitoramento esta rodando como servico systemd"
echo "Para verificar o status: systemctl status dual-wan-monitor"
echo "Logs do monitoramento: /var/log/dual_wan_monitor.log"
echo "==========================================================="