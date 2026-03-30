# zz_start

## Resumo
Caminhos e variáveis globais

## Execucao e parametros
- Local original: zz/zz_start
- Categoria: zz
- Exige root: sim
- Interativo: nao
- Nao foi encontrada ajuda embutida clara; revisar variaveis internas e chamadas diretas no arquivo.

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.
- curl (curl) - Downloads HTTP/HTTPS, descoberta de IP publico e chamadas a APIs.
- wget (wget) - Fallback de download e consultas simples via HTTP/HTTPS.
- ntpdate (ntpdate) - Sincronizacao de horario antes de rotinas sensiveis a data/hora.
- rclone (rclone) - Sincronizacao com remotos locais e nuvem.
- rsync (rsync) - Sincronizacao local ou entre mounts CIFS.
- sshpass (sshpass) - Automacao de autenticacao em SSH, SSHFS e SCP.
- parted (parted) - Particionamento de discos.
- mdadm (mdadm) - Criacao e gerenciamento de arrays RAID.
- dos2unix (dos2unix) - Normalizacao de finais de linha apos download.
- msmtp (msmtp, msmtp-mta) - Envio de e-mail via SMTP.
- mime-construct (mime-construct) - Montagem de mensagem MIME e anexos.
- mergerfs (mergerfs) - Uniao de varios discos em um destino logico.
- bc (bc) - Calculos com ponto flutuante.

## Arquivos e caminhos usados
- /etc/scripts
- ~/.bashrc
- data_hora.log
- zz_down.ini

## Funcionamento
- Valida privilegios de execucao antes de seguir.
- Prepara diretorios de trabalho, logs ou pontos de montagem.
- Executa a rotina principal definida no proprio arquivo e mostra o resultado em tela.

## Observacoes
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
