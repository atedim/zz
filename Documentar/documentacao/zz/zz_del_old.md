# zz_del_old

## Resumo
SCRIPT: zz_del_old DESCRICAO: Lista e remove arquivos antigos em um diretorio alvo e suas subpastas.

## Execucao e parametros
- Local original: zz/zz_del_old
- Categoria: zz
- Exige root: nao detectado explicitamente
- Interativo: sim
- USO:
- ./zz_del_old [modo] [diretorio]
- EXEMPLOS:
- ./zz_del_old
- ./zz_del_old log
- ./zz_del_old v "/dados/backups"

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.

## Arquivos e caminhos usados
- /var/log/clean_old_files
- /dr/bkp/matriz/servers/8/rede/geral/scan
- clean_DDMMAAAA_HHMM.log

## Funcionamento
- Solicita entradas do operador para definir parametros ou confirmar a operacao.
- Prepara diretorios de trabalho, logs ou pontos de montagem.
- Executa a rotina principal definida no proprio arquivo e mostra o resultado em tela.

## Observacoes
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
