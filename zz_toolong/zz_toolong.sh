#!/usr/bin/env bash

set -u

# Limites em quantidade de caracteres.
LIMITE_PASTAS=230
LIMITE_NOME_ARQUIVO=50
LIMITE_TOTAL=257

# Desconto aplicado uma unica vez em cada medicao antes da comparacao.
ANISTIA=10

# Use S para ignorar arquivos temporarios do Office que comecam com ~$.
ignora_temp=N

# Mostra status no terminal a cada N itens analisados. Use 0 para desligar.
INTERVALO_STATUS=100

# Pasta que sera analisada. Pode ser informada como primeiro argumento.
RAIZ="."

DATA_HORA="$(date '+%Y%m%d_%H%M%S')"
LOG="zz_toolong_${DATA_HORA}.log"

mostra_ajuda() {
  cat <<'EOF'
Uso:
  ./zz_toolong.sh [pasta] [opcoes]

Opcoes:
  --pastas N       Limite para caminho de pastas. Padrao: 230
  --arquivo N      Limite para nome de arquivo. Padrao: 30
  --total N        Limite para caminho total. Padrao: 257
  --anistia N      Desconto aplicado uma vez em cada medicao. Padrao: 0
  --ignora-temp S  Ignora arquivos temporarios do Office que comecam com ~$.
  --ignora-temp N  Nao ignora arquivos temporarios do Office. Padrao: N
  --status N       Mostra progresso a cada N itens analisados. Padrao: 1000
  --log ARQUIVO    Nome do arquivo de log.
  --help           Mostra esta ajuda.

Exemplos:
  ./zz_toolong.sh /dados/bkp/filiais/40
  ./zz_toolong.sh /dados/bkp/filiais/40 --arquivo 40 --anistia 10 --ignora-temp S
  ./zz_toolong.sh --pastas 230 --arquivo 40 --total 257 --anistia 10 .
EOF
}

erro() {
  echo "Erro: $1" >&2
  exit 1
}

valida_numero() {
  local nome="$1"
  local valor="$2"

  if [[ ! "$valor" =~ ^[0-9]+$ ]]; then
    erro "$nome precisa ser um numero inteiro maior ou igual a zero: $valor"
  fi
}

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --pastas)
      [[ "$#" -ge 2 ]] || erro "--pastas precisa de um valor"
      valida_numero "--pastas" "$2"
      LIMITE_PASTAS="$2"
      shift 2
      ;;
    --arquivo)
      [[ "$#" -ge 2 ]] || erro "--arquivo precisa de um valor"
      valida_numero "--arquivo" "$2"
      LIMITE_NOME_ARQUIVO="$2"
      shift 2
      ;;
    --total)
      [[ "$#" -ge 2 ]] || erro "--total precisa de um valor"
      valida_numero "--total" "$2"
      LIMITE_TOTAL="$2"
      shift 2
      ;;
    --anistia)
      [[ "$#" -ge 2 ]] || erro "--anistia precisa de um valor"
      valida_numero "--anistia" "$2"
      ANISTIA="$2"
      shift 2
      ;;
    --ignora-temp)
      [[ "$#" -ge 2 ]] || erro "--ignora-temp precisa ser S ou N"
      ignora_temp="${2^^}"
      [[ "$ignora_temp" == "S" || "$ignora_temp" == "N" ]] || erro "--ignora-temp precisa ser S ou N"
      shift 2
      ;;
    --log)
      [[ "$#" -ge 2 ]] || erro "--log precisa de um nome de arquivo"
      LOG="$2"
      shift 2
      ;;
    --status)
      [[ "$#" -ge 2 ]] || erro "--status precisa de um valor"
      valida_numero "--status" "$2"
      INTERVALO_STATUS="$2"
      shift 2
      ;;
    --help|-h)
      mostra_ajuda
      exit 0
      ;;
    --*)
      erro "opcao desconhecida: $1"
      ;;
    *)
      RAIZ="$1"
      shift
      ;;
  esac
done

if [[ "$RAIZ" != "/" ]]; then
  RAIZ="${RAIZ%/}"
fi

[[ -d "$RAIZ" ]] || erro "a pasta informada nao existe: $RAIZ"

TMP_ENTRADAS="$(mktemp -d -t zz_toolong_tmp.XXXXXX)"
trap 'rm -rf "$TMP_ENTRADAS"' EXIT

total_pastas=0
total_arquivos=0
total_alertas_pastas=0
total_alertas_nome_arquivo=0
total_alertas_total=0
total_temp_ignorados=0
total_analisados=0
sequencia=0

aplica_anistia() {
  local tamanho_real="$1"
  local tamanho_considerado=$((tamanho_real - ANISTIA))

  if [[ "$tamanho_considerado" -lt 0 ]]; then
    tamanho_considerado=0
  fi

  echo "$tamanho_considerado"
}

excesso() {
  local tamanho="$1"
  local limite="$2"
  local valor=$((tamanho - limite))

  if [[ "$valor" -lt 0 ]]; then
    valor=0
  fi

  echo "$valor"
}

junta_motivos() {
  local motivos=("$@")
  local texto="${motivos[0]}"
  local i

  for ((i = 1; i < ${#motivos[@]}; i++)); do
    texto+=", ${motivos[$i]}"
  done

  echo "$texto"
}

maior_valor() {
  local maior=0
  local valor

  for valor in "$@"; do
    if [[ "$valor" -gt "$maior" ]]; then
      maior="$valor"
    fi
  done

  echo "$maior"
}

grava_entrada() {
  local maior_excesso="$1"
  local bloco="$2"
  local arquivo

  sequencia=$((sequencia + 1))
  arquivo="$(printf '%s/%012d_%012d.entry' "$TMP_ENTRADAS" "$maior_excesso" "$sequencia")"
  printf '%s\n\n' "$bloco" > "$arquivo"
}

mostra_status() {
  if [[ "$INTERVALO_STATUS" -eq 0 ]]; then
    return
  fi

  if (( total_analisados % INTERVALO_STATUS == 0 )); then
    printf 'Analisados: %d | Pastas: %d | Arquivos: %d | Temporarios ignorados: %d\r' \
      "$total_analisados" "$total_pastas" "$total_arquivos" "$total_temp_ignorados"
  fi
}

while IFS= read -r -d '' caminho; do
  total_analisados=$((total_analisados + 1))
  nome="$(basename "$caminho")"
  caminho_relativo="${caminho#"$RAIZ"/}"

  if [[ -d "$caminho" ]]; then
    tamanho_pastas_real="${#caminho_relativo}"
    tamanho_pastas="$(aplica_anistia "$tamanho_pastas_real")"
    excesso_pastas="$(excesso "$tamanho_pastas" "$LIMITE_PASTAS")"

    if [[ "$excesso_pastas" -gt 0 ]]; then
      total_pastas=$((total_pastas + 1))
      total_alertas_pastas=$((total_alertas_pastas + 1))

      bloco="$(
        cat <<EOF
[PASTA]
Motivo: pastas>${LIMITE_PASTAS}
Maior excesso: ${excesso_pastas} caracteres
Excedeu pastas em: ${excesso_pastas} caracteres
Tamanho real das pastas: $tamanho_pastas_real
Anistia: $ANISTIA
Tamanho considerado das pastas: $tamanho_pastas
Limite das pastas: $LIMITE_PASTAS
Nome da pasta: $nome
Caminho relativo: $caminho_relativo
Caminho completo: $caminho
EOF
      )"
      grava_entrada "$excesso_pastas" "$bloco"
    fi
  elif [[ -f "$caminho" ]]; then
    if [[ "$ignora_temp" == "S" && "$nome" == '~$'* ]]; then
      total_temp_ignorados=$((total_temp_ignorados + 1))
      mostra_status
      continue
    fi

    caminho_pastas="$(dirname "$caminho_relativo")"
    if [[ "$caminho_pastas" == "." ]]; then
      caminho_pastas=""
    fi

    tamanho_pastas_real="${#caminho_pastas}"
    tamanho_nome_real="${#nome}"
    tamanho_total_real="${#caminho_relativo}"

    tamanho_pastas="$(aplica_anistia "$tamanho_pastas_real")"
    tamanho_nome="$(aplica_anistia "$tamanho_nome_real")"
    tamanho_total="$(aplica_anistia "$tamanho_total_real")"

    excesso_pastas="$(excesso "$tamanho_pastas" "$LIMITE_PASTAS")"
    excesso_nome="$(excesso "$tamanho_nome" "$LIMITE_NOME_ARQUIVO")"
    excesso_total="$(excesso "$tamanho_total" "$LIMITE_TOTAL")"

    motivos=()

    if [[ "$excesso_pastas" -gt 0 ]]; then
      motivos+=("pastas>${LIMITE_PASTAS}")
      total_alertas_pastas=$((total_alertas_pastas + 1))
    fi

    if [[ "$excesso_nome" -gt 0 ]]; then
      motivos+=("nome_arquivo>${LIMITE_NOME_ARQUIVO}")
      total_alertas_nome_arquivo=$((total_alertas_nome_arquivo + 1))
    fi

    if [[ "$excesso_total" -gt 0 ]]; then
      motivos+=("total>${LIMITE_TOTAL}")
      total_alertas_total=$((total_alertas_total + 1))
    fi

    if [[ "${#motivos[@]}" -gt 0 ]]; then
      total_arquivos=$((total_arquivos + 1))
      motivo="$(junta_motivos "${motivos[@]}")"
      maior_excesso="$(maior_valor "$excesso_pastas" "$excesso_nome" "$excesso_total")"

      bloco="$(
        cat <<EOF
[ARQUIVO]
Motivo: $motivo
Maior excesso: ${maior_excesso} caracteres
Excedeu pastas em: ${excesso_pastas} caracteres
Excedeu nome do arquivo em: ${excesso_nome} caracteres
Excedeu total em: ${excesso_total} caracteres
Anistia: $ANISTIA
Tamanho real das pastas: $tamanho_pastas_real
Tamanho considerado das pastas: $tamanho_pastas
Limite das pastas: $LIMITE_PASTAS
Tamanho real do nome do arquivo: $tamanho_nome_real
Tamanho considerado do nome do arquivo: $tamanho_nome
Limite do nome do arquivo: $LIMITE_NOME_ARQUIVO
Tamanho real total: $tamanho_total_real
Tamanho considerado total: $tamanho_total
Limite total: $LIMITE_TOTAL
Nome do arquivo: $nome
Caminho das pastas: $caminho_pastas
Caminho relativo total: $caminho_relativo
Caminho completo: $caminho
EOF
      )"
      grava_entrada "$maior_excesso" "$bloco"
    fi
  fi

  mostra_status
done < <(find "$RAIZ" -mindepth 1 -print0)

if [[ "$INTERVALO_STATUS" -ne 0 ]]; then
  printf 'Analisados: %d | Pastas: %d | Arquivos: %d | Temporarios ignorados: %d\n' \
    "$total_analisados" "$total_pastas" "$total_arquivos" "$total_temp_ignorados"
fi

{
  echo "zz_toolong - verificacao de caminhos longos"
  echo "Data: $(date '+%Y-%m-%d %H:%M:%S')"
  echo "Raiz analisada: $(realpath "$RAIZ")"
  echo "Limite para caminho de pastas: ${LIMITE_PASTAS} caracteres"
  echo "Limite para nome de arquivo: ${LIMITE_NOME_ARQUIVO} caracteres"
  echo "Limite para caminho total: ${LIMITE_TOTAL} caracteres"
  echo "Anistia aplicada por medicao: ${ANISTIA} caracteres"
  echo "ignora_temp: ${ignora_temp}"
  echo "Intervalo de status no terminal: ${INTERVALO_STATUS}"
  echo "Ordenacao: maior excesso primeiro"
  echo "------------------------------------------------------------"
  echo
} > "$LOG"

while IFS= read -r -d '' entrada; do
  cat "$entrada" >> "$LOG"
done < <(find "$TMP_ENTRADAS" -type f -name '*.entry' -print0 | sort -z -r)

{
  echo
  echo "------------------------------------------------------------"
  echo "Resumo"
  echo "Pastas acima do limite de pastas: $total_pastas"
  echo "Arquivos com algum limite excedido: $total_arquivos"
  echo "Alertas por tamanho das pastas: $total_alertas_pastas"
  echo "Alertas por nome do arquivo: $total_alertas_nome_arquivo"
  echo "Alertas por tamanho total: $total_alertas_total"
  echo "Arquivos temporarios do Office ignorados: $total_temp_ignorados"
  echo "Itens analisados: $total_analisados"
  echo "Log gerado em: $LOG"
} >> "$LOG"

echo "Verificacao concluida."
echo "Pastas acima do limite de pastas: $total_pastas"
echo "Arquivos com algum limite excedido: $total_arquivos"
echo "Arquivos temporarios do Office ignorados: $total_temp_ignorados"
echo "Log gerado em: $LOG"
