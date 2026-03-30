# zz_remote_bkp.sh

## Resumo
Documentacao automatica do script zz_remote_bkp.sh, baseada em analise estatica do arquivo Bash.

## Execucao e parametros
- Local original: zz/bkp/zz_remote_bkp/zz_remote_bkp.sh
- Categoria: zz/bkp/zz_remote_bkp
- Exige root: nao detectado explicitamente
- Interativo: sim
- Nao foi encontrada ajuda embutida clara; revisar variaveis internas e chamadas diretas no arquivo.

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.
- openssh-client/scp (openssh-client) - Conexao SSH e transferencia SCP.
- sshpass (sshpass) - Automacao de autenticacao em SSH, SSHFS e SCP.
- iproute2 (iproute2) - Consulta e configuracao de interfaces, rotas e regras.
- zstd (zstd) - Compressao para backups remotos.

## Arquivos e caminhos usados
- /etc/scripts/zz_remote_bkp
- /etc/crontab
- /etc/cron.d
- /etc/cron.daily
- /etc/cron.hourly
- /etc/cron.weekly
- /etc/cron.monthly
- zz_remote_bkp.conf

## Funcionamento
- Confere dependencias externas e aborta cedo se algo obrigatorio estiver ausente.
- Solicita entradas do operador para definir parametros ou confirmar a operacao.
- Prepara diretorios de trabalho, logs ou pontos de montagem.
- Executa a rotina principal definida no proprio arquivo e mostra o resultado em tela.

## Observacoes
- O arquivo contem valores sensiveis hardcoded; revise credenciais, tokens e senhas antes de usar em producao.
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
