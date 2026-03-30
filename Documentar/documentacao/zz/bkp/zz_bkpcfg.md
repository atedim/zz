# zz_bkpcfg

## Resumo
SCRIPT DE BACKUP DE CONFIGURAÇÕES DE SISTEMA Nome.........: zz_bkpcfg Descrição....: Realiza o backup de diretórios importantes e da crontab

## Execucao e parametros
- Local original: zz/bkp/zz_bkpcfg
- Categoria: zz/bkp
- Exige root: nao detectado explicitamente
- Interativo: nao
- Uso:
- ./zz_bkpcfg -> Executa backup e remove arquivos antigos
- ./zz_bkpcfg -nodel -> Executa backup sem excluir backups antigos
- ./zz_bkpcfg -mail -> Executa backup e envia e-mail
- Flag detectada: -nodel
- Flag detectada: -mail

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.
- openssh-client/scp (openssh-client) - Conexao SSH e transferencia SCP.
- iproute2 (iproute2) - Consulta e configuracao de interfaces, rotas e regras.
- samba (samba) - Arquivos de configuracao SMB e cenarios de compartilhamento local.

## Arquivos e caminhos usados
- /etc/scripts/cron.txt.
- /etc/scripts
- /etc/fstab
- /etc/ssh
- /etc/samba
- /etc/wireguard
- /etc/network
- /etc/scripts/bkp_configs
- /etc/scripts/cron.txt
- cron.txt

## Funcionamento
- Prepara diretorios de trabalho, logs ou pontos de montagem.
- Gera backup, compacta dados ou aplica retencao sobre artefatos antigos.

## Observacoes
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
