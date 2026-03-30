# zz_mountSSH

## Resumo
zz_mountSSH v1.0 Projeto zz_* - Montagem remota controlada via SSHFS FINALIDADE:

## Execucao e parametros
- Local original: zz/zz_mountSSH
- Categoria: zz
- Exige root: nao detectado explicitamente
- Interativo: sim
- Flag detectada: -s
- Flag detectada: -silent
- Flag detectada: -d
- Flag detectada: -debug
- Flag detectada: -u
- Flag detectada: -umount
- Flag detectada: -f
- Flag detectada: -F

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.
- openssh-client/scp (openssh-client) - Conexao SSH e transferencia SCP.
- sshpass (sshpass) - Automacao de autenticacao em SSH, SSHFS e SCP.
- sshfs (sshfs) - Montagem de diretorios remotos via FUSE.
- iproute2 (iproute2) - Consulta e configuracao de interfaces, rotas e regras.
- e2fsprogs/util-linux (e2fsprogs, util-linux) - Ferramentas como mkfs.ext4, e2label, blkid, wipefs, lsblk, mount e umount.

## Arquivos e caminhos usados
- /mnt/temp01

## Funcionamento
- Confere dependencias externas e aborta cedo se algo obrigatorio estiver ausente.
- Solicita entradas do operador para definir parametros ou confirmar a operacao.
- Prepara diretorios de trabalho, logs ou pontos de montagem.
- Executa a rotina principal definida no proprio arquivo e mostra o resultado em tela.

## Observacoes
- O arquivo contem valores sensiveis hardcoded; revise credenciais, tokens e senhas antes de usar em producao.
- O shebang da primeira linha esta malformado (`o#!/bin/bash`).
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
