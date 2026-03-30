# zz_careful

## Resumo
limpa_dir_rapido.sh - Limpa completamente uma pasta de forma otimizada ./limpa_dir_rapido.sh [CAMINHO_DA_PASTA] [-v|--verbose] CAMINHO_DA_PASTA Diretório que será limpo. Se não for informado, usa a pasta atual.

## Execucao e parametros
- Local original: zz/zz_careful
- Categoria: zz
- Exige root: nao detectado explicitamente
- Interativo: sim
- Uso:
- ./limpa_dir_rapido.sh [CAMINHO_DA_PASTA] [-v|--verbose]
- Parâmetros:
- Exemplo:
- ./limpa_dir_rapido.sh /home/usuario/teste -v
- Função para exibir ajuda
- Verifica se foi pedido help
- Flag detectada: -h

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.

## Arquivos e caminhos usados
- O script nao referencia arquivos auxiliares de forma evidente na analise estatica.

## Funcionamento
- Solicita entradas do operador para definir parametros ou confirmar a operacao.
- Executa a rotina principal definida no proprio arquivo e mostra o resultado em tela.

## Observacoes
- Possui operacoes potencialmente destrutivas; revisar caminhos, discos e parametros antes de executar.
