# zz_crypt

## Resumo
Utilitário de Criptografia e Descriptografia de Datas Funções: Criptografia leve: ROT13 + base64 + rev

## Execucao e parametros
- Local original: zz/kill_switch/zz_crypt
- Categoria: zz/kill_switch
- Exige root: nao detectado explicitamente
- Interativo: sim
- Flag detectada: -cl
- Flag detectada: -dl
- Flag detectada: -cf
- Flag detectada: -df
- Flag detectada: -p
- Flag detectada: -h
- Flag detectada: --help

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- openssl (openssl) - Criptografia e descriptografia de conteudo.

## Arquivos e caminhos usados
- O script nao referencia arquivos auxiliares de forma evidente na analise estatica.

## Funcionamento
- Solicita entradas do operador para definir parametros ou confirmar a operacao.
- Executa a rotina principal definida no proprio arquivo e mostra o resultado em tela.

## Observacoes
- O arquivo contem valores sensiveis hardcoded; revise credenciais, tokens e senhas antes de usar em producao.
