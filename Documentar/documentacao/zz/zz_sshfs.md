# zz_sshfs

## Resumo
Monta ou desmonta diretorios remotos via SSHFS.

## Execucao e parametros
- Local original: zz/zz_sshfs
- Categoria: zz
- Exige root: sim
- Interativo: nao
- Nao foi encontrada ajuda embutida clara; revisar variaveis internas e chamadas diretas no arquivo.

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- openssh-client/scp (openssh-client) - Conexao SSH e transferencia SCP.
- sshpass (sshpass) - Automacao de autenticacao em SSH, SSHFS e SCP.
- sshfs (sshfs) - Montagem de diretorios remotos via FUSE.
- e2fsprogs/util-linux (e2fsprogs, util-linux) - Ferramentas como mkfs.ext4, e2label, blkid, wipefs, lsblk, mount e umount.

## Arquivos e caminhos usados
- /mnt/vps

## Funcionamento
- Valida privilegios de execucao antes de seguir.
- Confere dependencias externas e aborta cedo se algo obrigatorio estiver ausente.
- Prepara diretorios de trabalho, logs ou pontos de montagem.
- Executa a rotina principal definida no proprio arquivo e mostra o resultado em tela.

## Observacoes
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
