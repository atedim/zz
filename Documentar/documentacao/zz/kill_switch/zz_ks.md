# zz_ks

## Resumo
Verificador de prazo criptografado via HTTP Este script realiza as seguintes funções: 1. Atualiza a data/hora do sistema via NTP (obrigatório).

## Execucao e parametros
- Local original: zz/kill_switch/zz_ks
- Categoria: zz/kill_switch
- Exige root: nao detectado explicitamente
- Interativo: nao
- Exemplo de uso:
- ./verifica_data.sh http://exemplo.com/data.txt
- ./verifica_data.sh -s http://exemplo.com/data.txt
- Flag detectada: -s

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- curl (curl) - Downloads HTTP/HTTPS, descoberta de IP publico e chamadas a APIs.
- ntpdate (ntpdate) - Sincronizacao de horario antes de rotinas sensiveis a data/hora.
- openssl (openssl) - Criptografia e descriptografia de conteudo.

## Arquivos e caminhos usados
- data.txt

## Funcionamento
- Executa a rotina principal definida no proprio arquivo e mostra o resultado em tela.

## Observacoes
- O arquivo contem valores sensiveis hardcoded; revise credenciais, tokens e senhas antes de usar em producao.
