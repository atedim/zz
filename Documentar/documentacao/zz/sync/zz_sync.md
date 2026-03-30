# zz_sync

## Resumo
zz_sync improved 22/10/2024 Sincronizacao de 2 pontos com protecao contra ransomware

## Execucao e parametros
- Local original: zz/sync/zz_sync
- Categoria: zz/sync
- Exige root: nao detectado explicitamente
- Interativo: sim
- Exemplo de arquivo de config
- [hostname1]
- IP=xxx.xxx.xxx.xxx
- share=/exemplo/
- uso:
- zz_sync origem destino
- zz_sync listar: Permite visualizar o conteudo completo do arquivo de configuracao ao executar o comando zz_sync listar.
- zz_sync decide: Permite a escolha da origem e destino interativamente.

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.
- rsync (rsync) - Sincronizacao local ou entre mounts CIFS.
- cifs-utils (cifs-utils) - Montagem de compartilhamentos SMB/CIFS.
- iproute2 (iproute2) - Consulta e configuracao de interfaces, rotas e regras.
- e2fsprogs/util-linux (e2fsprogs, util-linux) - Ferramentas como mkfs.ext4, e2label, blkid, wipefs, lsblk, mount e umount.

## Arquivos e caminhos usados
- /etc/scripts/zz_syncA.conf
- /etc/scripts/sync.log
- /mnt/origem
- /mnt/destino
- zz_syncA.conf
- sync.log
- controle.txt

## Funcionamento
- Confere dependencias externas e aborta cedo se algo obrigatorio estiver ausente.
- Solicita entradas do operador para definir parametros ou confirmar a operacao.
- Prepara diretorios de trabalho, logs ou pontos de montagem.
- Carrega origem/destino e executa sincronizacao com rsync ou rclone.

## Observacoes
- O arquivo contem valores sensiveis hardcoded; revise credenciais, tokens e senhas antes de usar em producao.
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
