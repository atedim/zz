# zz_ddns

## Resumo
Verificar se está sendo executado como root

## Execucao e parametros
- Local original: zz/network/zz_ddns
- Categoria: zz/network
- Exige root: sim
- Interativo: nao
- Nao foi encontrada ajuda embutida clara; revisar variaveis internas e chamadas diretas no arquivo.

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- curl (curl) - Downloads HTTP/HTTPS, descoberta de IP publico e chamadas a APIs.
- iproute2 (iproute2) - Consulta e configuracao de interfaces, rotas e regras.

## Arquivos e caminhos usados
- /etc/scripts/duckdns
- duck.log

## Funcionamento
- Valida privilegios de execucao antes de seguir.
- Prepara diretorios de trabalho, logs ou pontos de montagem.
- Executa consultas, testes ou alteracoes de rede e registra o resultado.

## Observacoes
- O arquivo contem valores sensiveis hardcoded; revise credenciais, tokens e senhas antes de usar em producao.
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
