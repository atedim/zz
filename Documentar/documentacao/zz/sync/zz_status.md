# zz_status

## Resumo
Acompanha continuamente um arquivo de log especifico.

## Execucao e parametros
- Local original: zz/sync/zz_status
- Categoria: zz/sync
- Exige root: nao detectado explicitamente
- Interativo: nao
- Nao foi encontrada ajuda embutida clara; revisar variaveis internas e chamadas diretas no arquivo.

## Requisitos
- bash (bash) - Interpretador principal dos scripts.

## Arquivos e caminhos usados
- /etc/scripts/sync.log
- sync.log

## Funcionamento
- Carrega origem/destino e executa sincronizacao com rsync ou rclone.

## Observacoes
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
