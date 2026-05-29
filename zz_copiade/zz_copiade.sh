#!/usr/bin/env bash
set -Eeuo pipefail

###############################################################################
# CONFIGURACAO
###############################################################################

# Pasta que sera verificada.
# Se voce passar uma pasta como argumento, ela substitui este valor.
TARGET_DIR="."

# Quantas vezes a palavra "copia" ou "cópia" precisa aparecer no nome.
MIN_COPIA_COUNT=3

# O arquivo precisa ter sido modificado ha mais de quantos dias.
MIN_AGE_DAYS=32

# false = apenas registra no log
# true  = remove os arquivos encontrados
REMOVE_MATCHES=false

# Onde salvar o log.
LOG_FILE="./zz_copiade.log"

###############################################################################

usage() {
  cat <<'USAGE'
Uso:
  ./zz_copiade.sh [PASTA]

Variaveis:
  MIN_COPIA_COUNT=3        minimo de vezes que "copia"/"cópia" deve aparecer
  MIN_AGE_DAYS=30          idade minima em dias desde a ultima modificacao
  REMOVE_MATCHES=false     true remove os arquivos encontrados
  LOG_FILE=./zz_copiade.log caminho do log

Exemplos:
  ./zz_copiade.sh "/mnt/arquivos"
  MIN_COPIA_COUNT=5 MIN_AGE_DAYS=90 ./zz_copiade.sh "/mnt/arquivos"
  REMOVE_MATCHES=true ./zz_copiade.sh "/mnt/arquivos"
USAGE
}

fail() {
  printf 'Erro: %s\n' "$*" >&2
  exit 1
}

log_line() {
  printf '%s | %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" >> "$LOG_FILE"
}

normalize_name() {
  local value="$1"

  value="${value,,}"
  value="${value//Á/a}"
  value="${value//À/a}"
  value="${value//Â/a}"
  value="${value//Ã/a}"
  value="${value//Ä/a}"
  value="${value//á/a}"
  value="${value//à/a}"
  value="${value//â/a}"
  value="${value//ã/a}"
  value="${value//ä/a}"
  value="${value//É/e}"
  value="${value//Ê/e}"
  value="${value//Ë/e}"
  value="${value//é/e}"
  value="${value//ê/e}"
  value="${value//ë/e}"
  value="${value//Í/i}"
  value="${value//Ï/i}"
  value="${value//í/i}"
  value="${value//ï/i}"
  value="${value//Ó/o}"
  value="${value//Ô/o}"
  value="${value//Õ/o}"
  value="${value//Ö/o}"
  value="${value//ó/o}"
  value="${value//ô/o}"
  value="${value//õ/o}"
  value="${value//ö/o}"
  value="${value//Ú/u}"
  value="${value//Ü/u}"
  value="${value//ú/u}"
  value="${value//ü/u}"
  value="${value//Ç/c}"
  value="${value//ç/c}"

  printf '%s' "$value"
}

count_copia() {
  local normalized="$1"
  local without_matches="${normalized//copia/}"
  local diff=$(( ${#normalized} - ${#without_matches} ))

  printf '%s' $(( diff / 5 ))
}

file_mtime() {
  local file="$1"
  local mtime_epoch

  mtime_epoch="$(file_mtime_epoch "$file")"
  date -d "@$mtime_epoch" '+%Y-%m-%d %H:%M:%S' 2>/dev/null || date -r "$mtime_epoch" '+%Y-%m-%d %H:%M:%S'
}

file_mtime_epoch() {
  local file="$1"
  stat -c '%Y' "$file" 2>/dev/null || stat -f '%m' "$file"
}

main() {
  if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    usage
    exit 0
  fi

  if [[ -n "${1:-}" ]]; then
    TARGET_DIR="$1"
  fi

  [[ -d "$TARGET_DIR" ]] || fail "pasta nao encontrada: $TARGET_DIR"
  [[ "$MIN_COPIA_COUNT" =~ ^[0-9]+$ ]] || fail "MIN_COPIA_COUNT deve ser numero inteiro"
  [[ "$MIN_AGE_DAYS" =~ ^[0-9]+$ ]] || fail "MIN_AGE_DAYS deve ser numero inteiro"
  [[ "$REMOVE_MATCHES" == "true" || "$REMOVE_MATCHES" == "false" ]] || fail "REMOVE_MATCHES deve ser true ou false"

  mkdir -p "$(dirname "$LOG_FILE")"

  local scanned=0
  local matched=0
  local removed=0
  local now_epoch
  now_epoch="$(date '+%s')"

  log_line "inicio | pasta=$TARGET_DIR | minimo_copias=$MIN_COPIA_COUNT | minimo_dias=$MIN_AGE_DAYS | remover=$REMOVE_MATCHES"

  while IFS= read -r -d '' file; do
    scanned=$((scanned + 1))

    local base normalized copies mtime_epoch age_days mtime
    base="$(basename "$file")"
    normalized="$(normalize_name "$base")"
    copies="$(count_copia "$normalized")"

    if (( copies < MIN_COPIA_COUNT )); then
      continue
    fi

    mtime_epoch="$(file_mtime_epoch "$file")"
    age_days=$(( ( now_epoch - mtime_epoch ) / 86400 ))

    if (( age_days <= MIN_AGE_DAYS )); then
      continue
    fi

    matched=$((matched + 1))
    mtime="$(file_mtime "$file")"

    if [[ "$REMOVE_MATCHES" == "true" ]]; then
      if rm -f -- "$file"; then
        removed=$((removed + 1))
        log_line "removido | copias=$copies | idade_dias=$age_days | minimo_dias=$MIN_AGE_DAYS | modificado=$mtime | arquivo=$file"
      else
        log_line "erro_remocao | copias=$copies | idade_dias=$age_days | minimo_dias=$MIN_AGE_DAYS | modificado=$mtime | arquivo=$file"
      fi
    else
      log_line "encontrado | copias=$copies | idade_dias=$age_days | minimo_dias=$MIN_AGE_DAYS | modificado=$mtime | arquivo=$file"
    fi
  done < <(find "$TARGET_DIR" -type f -print0)

  log_line "fim | verificados=$scanned | encontrados=$matched | removidos=$removed"

  printf 'Concluido. Verificados: %s | Encontrados: %s | Removidos: %s | Log: %s\n' \
    "$scanned" "$matched" "$removed" "$LOG_FILE"
}

main "$@"
