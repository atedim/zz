# zz_down

## Resumo
zz_down - Gerenciador de instalação de scripts personalizados

## Execucao e parametros
- Local original: zz/down/zz_down
- Categoria: zz/down
- Exige root: sim
- Interativo: sim
- Nao foi encontrada ajuda embutida clara; revisar variaveis internas e chamadas diretas no arquivo.

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.
- curl (curl) - Downloads HTTP/HTTPS, descoberta de IP publico e chamadas a APIs.
- wget (wget) - Fallback de download e consultas simples via HTTP/HTTPS.
- ntpdate (ntpdate) - Sincronizacao de horario antes de rotinas sensiveis a data/hora.
- dos2unix (dos2unix) - Normalizacao de finais de linha apos download.

## Arquivos e caminhos usados
- /etc/scripts
- ~/.bashrc
- zz_down.ini
- curl_error.log
- wget_error.log

## Funcionamento
- Valida privilegios de execucao antes de seguir.
- Confere dependencias externas e aborta cedo se algo obrigatorio estiver ausente.
- Solicita entradas do operador para definir parametros ou confirmar a operacao.
- Prepara diretorios de trabalho, logs ou pontos de montagem.
- Executa a rotina principal definida no proprio arquivo e mostra o resultado em tela.

## Observacoes
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
