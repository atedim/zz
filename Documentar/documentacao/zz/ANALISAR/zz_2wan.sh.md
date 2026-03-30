# zz_2wan.sh

## Resumo
Script de Configuracao Dual WAN para Linux Este script configura duas interfaces de rede em modo failover ou balanceamento de carga, com suporte a DHCP.

## Execucao e parametros
- Local original: zz/ANALISAR/zz_2wan.sh
- Categoria: zz/ANALISAR
- Exige root: sim
- Interativo: sim
- Nao foi encontrada ajuda embutida clara; revisar variaveis internas e chamadas diretas no arquivo.

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.
- curl (curl) - Downloads HTTP/HTTPS, descoberta de IP publico e chamadas a APIs.
- iproute2 (iproute2) - Consulta e configuracao de interfaces, rotas e regras.
- ping (iputils-ping ou inetutils-ping) - Teste de conectividade.
- ipcalc (ipcalc) - Calculo de rede CIDR em configuracao dual WAN.
- systemd (systemd) - Controle de servicos e unidades do sistema.

## Arquivos e caminhos usados
- /etc/scripts/
- /etc/iproute2/rt_tables
- /etc/systemd/system/dual-wan-monitor.service
- /etc/network/dual_wan_setup.sh
- /etc/network/if-up.d
- /etc/network/if-up.d/dual-wan
- /etc/rc.local
- /var/log/dual_wan_monitor.log
- dual_wan_monitor.log

## Funcionamento
- Valida privilegios de execucao antes de seguir.
- Solicita entradas do operador para definir parametros ou confirmar a operacao.
- Prepara diretorios de trabalho, logs ou pontos de montagem.
- Executa a rotina principal definida no proprio arquivo e mostra o resultado em tela.

## Observacoes
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
