# zz_trash

## Resumo
Limpa Lixeira v0.03 - Antonio M. Tedim - 16/04/2025

## Execucao e parametros
- Local original: zz/file_folder/zz_trash
- Categoria: zz/file_folder
- Exige root: nao detectado explicitamente
- Interativo: nao
- Nao foi encontrada ajuda embutida clara; revisar variaveis internas e chamadas diretas no arquivo.

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.
- ntpdate (ntpdate) - Sincronizacao de horario antes de rotinas sensiveis a data/hora.

## Arquivos e caminhos usados
- O script nao referencia arquivos auxiliares de forma evidente na analise estatica.

## Funcionamento
- Confere dependencias externas e aborta cedo se algo obrigatorio estiver ausente.
- Percorre o sistema de arquivos para listar, medir, ajustar atributos ou remover itens.

## Observacoes
- Possui operacoes potencialmente destrutivas; revisar caminhos, discos e parametros antes de executar.
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
