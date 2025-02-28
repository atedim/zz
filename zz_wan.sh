#!/bin/bash

# Configurações
EMAIL_TO="system@grupoalbatroz.com.br"
EMAIL_FROM="send@grupoalbatroz.com.br"
EMAIL_SUBJECT="Alteração de IP WAN Detectada - Alba Matriz"
LOG_FILE="/etc/scripts/log/ip_changes.log"
IP_FILE="/etc/scripts/log/wan_ip.txt"

# Configurações DuckDNS
DUCKDNS_DOMAIN="albamatriz"
DUCKDNS_TOKEN="bf52ad64-74d1-44fd-9718-a398a4ffeafa&ip"
DUCKDNS_URL="https://www.duckdns.org/update"

# Mensagens a serem filtradas (sem envio de email)
msg_filter="upstream request timeout"

# Cria diretórios e arquivos se não existirem
mkdir -p "$(dirname "$IP_FILE")" "$(dirname "$LOG_FILE")"
touch "$IP_FILE" "$LOG_FILE"

# Função para obter o IP WAN atual
get_wan_ip() {
    local ip=$(curl -s ifconfig.me || \
               curl -s icanhazip.com || \
               curl -s ipecho.net/plain || \
               curl -s ident.me)
    echo "$ip"
}

# Função para enviar email
send_email() {
    local old_ip="$1"
    local new_ip="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local message="Mudança de IP WAN detectada em $timestamp\n\nIP Antigo: $old_ip\nNovo IP: $new_ip"

    echo -e "To: ${EMAIL_TO}\nFrom: ${EMAIL_FROM}\nSubject: ${EMAIL_SUBJECT}\n\n${message}" | ssmtp ${EMAIL_TO}
}

# Função para registrar em log
log_change() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$timestamp - $message" >> "$LOG_FILE"
}

# Função para atualizar DuckDNS
update_duckdns() {
    local ip="$1"
    local response

    response=$(curl -s -k "${DUCKDNS_URL}?domains=${DUCKDNS_DOMAIN}&token=${DUCKDNS_TOKEN}&ip=${ip}")

    if [ "$response" = "OK" ]; then
        log_change "DuckDNS atualizado com sucesso para IP: $ip"
    else
        log_change "Erro ao atualizar DuckDNS para IP: $ip. Resposta: $response"
    fi
}

# Verifica dependências
if ! command -v ssmtp &> /dev/null || ! command -v curl &> /dev/null; then
    log_change "Erro: ssmtp ou curl não estão instalados."
    exit 1
fi

# Obtém o IP atual
NEW_IP=$(get_wan_ip)

# Verifica se conseguiu obter o IP
if [ -z "$NEW_IP" ]; then
    log_change "Erro: Não foi possível obter o IP atual."
    exit 1
fi

# Verifica se o IP corresponde às mensagens filtradas
if [ "$NEW_IP" = "$msg_filter" ]; then
    log_change "Ignorando alteração de IP: detectado '$msg_filter'"
    exit 0
fi

# Lê o IP anterior do arquivo
LAST_IP=""
if [ -f "$IP_FILE" ]; then
    LAST_IP=$(cat "$IP_FILE")
fi

# Se não houver IP anterior, registra o primeiro
if [ -z "$LAST_IP" ]; then
    echo "$NEW_IP" > "$IP_FILE"
    log_change "Primeiro IP registrado: $NEW_IP"
    update_duckdns "$NEW_IP"
    exit 0
fi

# Compara com o IP anterior
if [ "$NEW_IP" != "$LAST_IP" ]; then
    # Registra o novo IP
    echo "$NEW_IP" > "$IP_FILE"

    # Registra a mudança no log
    log_change "IP alterado de $LAST_IP para $NEW_IP"

    # Envia email de notificação
    send_email "$LAST_IP" "$NEW_IP"

    # Atualiza DDNS
    update_duckdns "$NEW_IP"
fi