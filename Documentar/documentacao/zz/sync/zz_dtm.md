# zz_dtm

## Resumo
zz_dtm Script para sincronizar backups do DTM usando o RCLONE ver 0.01 12/11/2024

## Execucao e parametros
- Local original: zz/sync/zz_dtm
- Categoria: zz/sync
- Exige root: nao detectado explicitamente
- Interativo: nao
- Nao foi encontrada ajuda embutida clara; revisar variaveis internas e chamadas diretas no arquivo.

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- ntpdate (ntpdate) - Sincronizacao de horario antes de rotinas sensiveis a data/hora.
- rclone (rclone) - Sincronizacao com remotos locais e nuvem.

## Arquivos e caminhos usados
- O script nao referencia arquivos auxiliares de forma evidente na analise estatica.

## Funcionamento
- Carrega origem/destino e executa sincronizacao com rsync ou rclone.

## Observacoes
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
