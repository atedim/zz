# zz_formata

## Resumo
Verifica se o parted esta instalado

## Execucao e parametros
- Local original: zz/disktools/zz_formata
- Categoria: zz/disktools
- Exige root: nao detectado explicitamente
- Interativo: sim
- Nao foi encontrada ajuda embutida clara; revisar variaveis internas e chamadas diretas no arquivo.

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.
- parted (parted) - Particionamento de discos.
- e2fsprogs/util-linux (e2fsprogs, util-linux) - Ferramentas como mkfs.ext4, e2label, blkid, wipefs, lsblk, mount e umount.

## Arquivos e caminhos usados
- O script nao referencia arquivos auxiliares de forma evidente na analise estatica.

## Funcionamento
- Confere dependencias externas e aborta cedo se algo obrigatorio estiver ausente.
- Solicita entradas do operador para definir parametros ou confirmar a operacao.
- Opera discos/volumes diretamente e pode alterar particionamento, fstab, RAID ou montagens.

## Observacoes
- Possui operacoes potencialmente destrutivas; revisar caminhos, discos e parametros antes de executar.
