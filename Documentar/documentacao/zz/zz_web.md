# zz_web

## Resumo
Gerencia o servico web Nginx e o arquivo .htpasswd.

## Execucao e parametros
- Local original: zz/zz_web
- Categoria: zz
- Exige root: nao detectado explicitamente
- Interativo: sim
- Flag detectada: -off
- Flag detectada: -start
- Flag detectada: -on
- Flag detectada: -pass
- Flag detectada: -add
- Flag detectada: -del
- Flag detectada: -list

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.
- nginx (nginx) - Servico web controlado por zz_web.
- apache2-utils (apache2-utils) - Fornece o comando htpasswd.
- systemd (systemd) - Controle de servicos e unidades do sistema.

## Arquivos e caminhos usados
- /etc/nginx/.htpasswd

## Funcionamento
- Solicita entradas do operador para definir parametros ou confirmar a operacao.
- Executa a rotina principal definida no proprio arquivo e mostra o resultado em tela.

## Observacoes
- Nao foram detectados alertas adicionais alem dos requisitos normais de execucao.
