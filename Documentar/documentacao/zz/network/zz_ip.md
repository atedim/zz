# zz_ip

## Resumo
zz_ip - Script para exibir informações de rede Opções: (nenhuma) Mostra HOSTNAME, IP LAN e IP WAN

## Execucao e parametros
- Local original: zz/network/zz_ip
- Categoria: zz/network
- Exige root: nao detectado explicitamente
- Interativo: nao
- Uso: ./zz_ip [opção]
- Opções:
- (nenhuma) Mostra HOSTNAME, IP LAN e IP WAN

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.
- curl (curl) - Downloads HTTP/HTTPS, descoberta de IP publico e chamadas a APIs.
- wget (wget) - Fallback de download e consultas simples via HTTP/HTTPS.
- iproute2 (iproute2) - Consulta e configuracao de interfaces, rotas e regras.
- net-tools (net-tools) - Fallback legado via ifconfig e route.
- ethtool (ethtool) - Consulta de velocidade e duplex de interfaces.

## Arquivos e caminhos usados
- /etc/resolv.conf
- resolv.conf

## Funcionamento
- Confere dependencias externas e aborta cedo se algo obrigatorio estiver ausente.
- Executa consultas, testes ou alteracoes de rede e registra o resultado.

## Observacoes
- Nao foram detectados alertas adicionais alem dos requisitos normais de execucao.
