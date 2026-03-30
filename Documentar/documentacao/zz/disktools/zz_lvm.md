# zz_lvm

## Resumo
Orquestra criacao de RAID, LVM, formatacao e montagem.

## Execucao e parametros
- Local original: zz/disktools/zz_lvm
- Categoria: zz/disktools
- Exige root: nao detectado explicitamente
- Interativo: sim
- Nao foi encontrada ajuda embutida clara; revisar variaveis internas e chamadas diretas no arquivo.

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.
- e2fsprogs/util-linux (e2fsprogs, util-linux) - Ferramentas como mkfs.ext4, e2label, blkid, wipefs, lsblk, mount e umount.
- mdadm (mdadm) - Criacao e gerenciamento de arrays RAID.
- lvm2 (lvm2) - Criacao de PV, VG e LV.
- whiptail (whiptail) - Menus interativos em modo texto.
- systemd (systemd) - Controle de servicos e unidades do sistema.

## Arquivos e caminhos usados
- /etc/mdadm/mdadm.conf
- /etc/fstab
- /var/log/raid_lvm_setup.log
- /mnt/dados
- raid_lvm_setup.log
- mdadm.conf

## Funcionamento
- Solicita entradas do operador para definir parametros ou confirmar a operacao.
- Prepara diretorios de trabalho, logs ou pontos de montagem.
- Opera discos/volumes diretamente e pode alterar particionamento, fstab, RAID ou montagens.

## Observacoes
- Possui operacoes potencialmente destrutivas; revisar caminhos, discos e parametros antes de executar.
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
