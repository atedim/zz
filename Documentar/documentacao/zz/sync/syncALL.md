# syncALL

## Resumo
Wrapper para executar uma ou mais sincronizacoes zz_sync com pares ja definidos.

## Execucao e parametros
- Local original: zz/sync/syncALL
- Categoria: zz/sync
- Exige root: nao detectado explicitamente
- Interativo: nao
- Nao foi encontrada ajuda embutida clara; revisar variaveis internas e chamadas diretas no arquivo.

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- e2fsprogs/util-linux (e2fsprogs, util-linux) - Ferramentas como mkfs.ext4, e2label, blkid, wipefs, lsblk, mount e umount.

## Arquivos e caminhos usados
- /mnt/disco_dia

## Funcionamento
- Carrega origem/destino e executa sincronizacao com rsync ou rclone.

## Observacoes
- Nao foram detectados alertas adicionais alem dos requisitos normais de execucao.
