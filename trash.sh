#!/bin/bash
## Limpa Lixeira v0.03 - Antonio M. Tedim - 16/04/2025

# Caminho base da lixeira
CAMINHO_BASE="/dados/lixeira"

# Dias de retencao dos arquivos (modificacoes mais antigas que isso serao excluidas)
MLAST=16

# Ajusta data e hora, se o comando ntpdate existir
command -v ntpdate >/dev/null && ntpdate pool.ntp.org

# Remove arquivos modificados há mais de $MLAST dias
find "$CAMINHO_BASE" -mindepth 1 -type f -mtime +"$MLAST" -print0 | xargs -r0 rm --

# Remove subpasta 'lixeira', se existir
[ -d "$CAMINHO_BASE/lixeira" ] && rm -rf "$CAMINHO_BASE/lixeira"

# Remove arquivos temporários (*.tmp, *.TMP, ~*)
find "$CAMINHO_BASE" -iname "*.tmp" -delete
find "$CAMINHO_BASE" -name "~*" -delete

# Remove arquivos vazios
find "$CAMINHO_BASE" -type f -empty -delete

# Remove diretórios vazios (recursivamente)
echo "Removendo pastas vazias (recursivamente)..."
while find "$CAMINHO_BASE" -type d -empty | grep -q .; do
    find "$CAMINHO_BASE" -type d -empty -print -delete
done
echo "Remocao concluida."
