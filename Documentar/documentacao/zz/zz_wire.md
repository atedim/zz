# zz_wire

## Resumo
Gerencia interfaces WireGuard e operacoes de peers.

## Execucao e parametros
- Local original: zz/zz_wire
- Categoria: zz
- Exige root: nao detectado explicitamente
- Interativo: sim
- Flag detectada: -list
- Flag detectada: -kill
- Flag detectada: -on
- Flag detectada: -start
- Flag detectada: -off
- Flag detectada: -restart
- Flag detectada: -status
- Flag detectada: -add

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.
- wireguard-tools (wireguard-tools) - Comandos wg e operacao de interfaces wg-quick.
- systemd (systemd) - Controle de servicos e unidades do sistema.

## Arquivos e caminhos usados
- /etc/wireguard
- 1.conf
- IFACE.conf

## Funcionamento
- Solicita entradas do operador para definir parametros ou confirmar a operacao.
- Executa a rotina principal definida no proprio arquivo e mostra o resultado em tela.

## Observacoes
- Nao foram detectados alertas adicionais alem dos requisitos normais de execucao.
