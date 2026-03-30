# zz_1to2

## Resumo
1to2_sync 09:46 19/12/2023 ver 0.01

## Execucao e parametros
- Local original: zz/sync/zz_1to2
- Categoria: zz/sync
- Exige root: nao detectado explicitamente
- Interativo: nao
- Nao foi encontrada ajuda embutida clara; revisar variaveis internas e chamadas diretas no arquivo.

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.
- rsync (rsync) - Sincronizacao local ou entre mounts CIFS.

## Arquivos e caminhos usados
- /work/g/8preta1/Dados/
- /work/g/8preta2/Dados/
- controle.txt

## Funcionamento
- Carrega origem/destino e executa sincronizacao com rsync ou rclone.

## Observacoes
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
