# zz_new

## Resumo
Wrapper para sincronizacao rclone pre-configurada entre origens e destinos fixos.

## Execucao e parametros
- Local original: zz/zz_new
- Categoria: zz
- Exige root: nao detectado explicitamente
- Interativo: nao
- Nao foi encontrada ajuda embutida clara; revisar variaveis internas e chamadas diretas no arquivo.

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- rclone (rclone) - Sincronizacao com remotos locais e nuvem.

## Arquivos e caminhos usados
- /var/log/rclone_sync.log
- /work/Dados
- rclone_sync.log

## Funcionamento
- Confere dependencias externas e aborta cedo se algo obrigatorio estiver ausente.
- Executa a rotina principal definida no proprio arquivo e mostra o resultado em tela.

## Observacoes
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
