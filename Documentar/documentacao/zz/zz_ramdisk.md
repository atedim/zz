# zz_ramdisk

## Resumo
ZZ_RAMLOADER - Carrega scripts em RAM Disk (tmpfs)

## Execucao e parametros
- Local original: zz/zz_ramdisk
- Categoria: zz
- Exige root: sim
- Interativo: nao
- Nao foi encontrada ajuda embutida clara; revisar variaveis internas e chamadas diretas no arquivo.

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.
- wget (wget) - Fallback de download e consultas simples via HTTP/HTTPS.
- e2fsprogs/util-linux (e2fsprogs, util-linux) - Ferramentas como mkfs.ext4, e2label, blkid, wipefs, lsblk, mount e umount.

## Arquivos e caminhos usados
- /var/log/zz_ramloader.log
- zz_ramloader.log

## Funcionamento
- Valida privilegios de execucao antes de seguir.
- Prepara diretorios de trabalho, logs ou pontos de montagem.
- Executa a rotina principal definida no proprio arquivo e mostra o resultado em tela.

## Observacoes
- Possui operacoes potencialmente destrutivas; revisar caminhos, discos e parametros antes de executar.
