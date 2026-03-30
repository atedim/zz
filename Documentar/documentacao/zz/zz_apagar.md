# zz_apagar

## Resumo
Script: limpa_pastas.sh Função: Lista ou apaga pastas contidas em um arquivo de texto comando pra limpar uma lista

## Execucao e parametros
- Local original: zz/zz_apagar
- Categoria: zz
- Exige root: nao detectado explicitamente
- Interativo: sim
- Flag detectada: -list
- Flag detectada: -del

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.

## Arquivos e caminhos usados
- /etc/scripts/zz_apagar.txt
- /etc/scripts/log/limpa_pastas
- /work/dados
- assistir.txt
- todos.txt
- assistidos.txt
- zz_apagar.txt

## Funcionamento
- Solicita entradas do operador para definir parametros ou confirmar a operacao.
- Prepara diretorios de trabalho, logs ou pontos de montagem.
- Executa a rotina principal definida no proprio arquivo e mostra o resultado em tela.

## Observacoes
- Possui operacoes potencialmente destrutivas; revisar caminhos, discos e parametros antes de executar.
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
