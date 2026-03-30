# zz_mail

## Resumo
Envia e-mails com ou sem anexo pela linha de comando.

## Execucao e parametros
- Local original: zz/mail/zz_mail
- Categoria: zz/mail
- Exige root: nao detectado explicitamente
- Interativo: sim
- Flag detectada: -config

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- msmtp (msmtp, msmtp-mta) - Envio de e-mail via SMTP.
- mime-construct (mime-construct) - Montagem de mensagem MIME e anexos.

## Arquivos e caminhos usados
- /etc/ssl/certs/ca-certificates.crt
- $HOME/.msmtprc
- ~/.msmtprc
- ~/.msmtp.log
- log.txt
- .msmtp.log

## Funcionamento
- Confere dependencias externas e aborta cedo se algo obrigatorio estiver ausente.
- Solicita entradas do operador para definir parametros ou confirmar a operacao.
- Executa a rotina principal definida no proprio arquivo e mostra o resultado em tela.

## Observacoes
- Nao foram detectados alertas adicionais alem dos requisitos normais de execucao.
