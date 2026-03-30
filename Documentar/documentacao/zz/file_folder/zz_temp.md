# zz_temp

## Resumo
Limpa Temps v0.01 - Apaga arquivos temporários antigos, pastas inuteis e afins ou apenas registra no log

## Execucao e parametros
- Local original: zz/file_folder/zz_temp
- Categoria: zz/file_folder
- Exige root: nao detectado explicitamente
- Interativo: nao
- Flag detectada: --logonly

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.
- ntpdate (ntpdate) - Sincronizacao de horario antes de rotinas sensiveis a data/hora.

## Arquivos e caminhos usados
- /etc/scripts

## Funcionamento
- Confere dependencias externas e aborta cedo se algo obrigatorio estiver ausente.
- Prepara diretorios de trabalho, logs ou pontos de montagem.
- Percorre o sistema de arquivos para listar, medir, ajustar atributos ou remover itens.

## Observacoes
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
