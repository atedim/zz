# zz_tcon

## Resumo
Executa testes de conectividade por DNS e por IP.

## Execucao e parametros
- Local original: zz/network/zz_tcon
- Categoria: zz/network
- Exige root: nao detectado explicitamente
- Interativo: sim
- Nao foi encontrada ajuda embutida clara; revisar variaveis internas e chamadas diretas no arquivo.

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.
- iproute2 (iproute2) - Consulta e configuracao de interfaces, rotas e regras.
- dnsutils (dnsutils) - Resolucao DNS via dig.
- ping (iputils-ping ou inetutils-ping) - Teste de conectividade.

## Arquivos e caminhos usados
- /etc/scripts/hostn.txt
- /etc/scripts/hostip.txt
- /etc/scripts/conectividade.log
- hostn.txt
- hostip.txt
- conectividade.log

## Funcionamento
- Solicita entradas do operador para definir parametros ou confirmar a operacao.
- Executa consultas, testes ou alteracoes de rede e registra o resultado.

## Observacoes
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
