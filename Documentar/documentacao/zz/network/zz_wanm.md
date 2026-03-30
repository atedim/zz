# zz_wanm

## Resumo
Documentacao automatica do script zz_wanm, baseada em analise estatica do arquivo Bash.

## Execucao e parametros
- Local original: zz/network/zz_wanm
- Categoria: zz/network
- Exige root: nao detectado explicitamente
- Interativo: nao
- Nao foi encontrada ajuda embutida clara; revisar variaveis internas e chamadas diretas no arquivo.

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- iproute2 (iproute2) - Consulta e configuracao de interfaces, rotas e regras.

## Arquivos e caminhos usados
- /etc/scripts/zz_wanm_logs/
- wan_ip_atual.txt
- wan_alteracoes.log
- wan_monitor_execucao.log

## Funcionamento
- Confere dependencias externas e aborta cedo se algo obrigatorio estiver ausente.
- Prepara diretorios de trabalho, logs ou pontos de montagem.
- Executa consultas, testes ou alteracoes de rede e registra o resultado.

## Observacoes
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
