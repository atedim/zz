# zz_dif_tam

## Resumo
zz_dif_tam - Compara duas pastas em termos de tamanho total (bytes) e número de arquivos. zz_dif_tam [origem] [destino] [silent] origem - Caminho da pasta origem

## Execucao e parametros
- Local original: zz/file_folder/zz_dif_tam
- Categoria: zz/file_folder
- Exige root: nao detectado explicitamente
- Interativo: nao
- Uso:
- zz_dif_tam [origem] [destino] [silent]
- Parâmetros:

## Requisitos
- bash (bash) - Interpretador principal dos scripts.
- coreutils/findutils/grep/sed/awk/tar (coreutils, findutils, grep, sed, gawk, tar) - Conjunto basico de utilitarios GNU usado no acervo.
- fd-find (fd-find) - Comando fdfind usado para inventario rapido de arquivos.

## Arquivos e caminhos usados
- /etc/logs/zz_dif_tam
- /etc/scripts/logs/zz_dif_tam.log
- zz_dif_tam.log

## Funcionamento
- Confere dependencias externas e aborta cedo se algo obrigatorio estiver ausente.
- Prepara diretorios de trabalho, logs ou pontos de montagem.
- Percorre o sistema de arquivos para listar, medir, ajustar atributos ou remover itens.

## Observacoes
- Assume uma estrutura de caminhos fixa no host e pode exigir ajuste manual em outro ambiente.
