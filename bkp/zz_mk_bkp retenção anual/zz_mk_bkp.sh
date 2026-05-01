#!/bin/bash

BASE_DIR="/etc/scripts/zz_mk_bkp"
CONF_FILE="${BASE_DIR}/zz_mk_bkp.conf"
LOG_DIR="${BASE_DIR}/logs"
BKP_DIR="${BASE_DIR}/bkp"

LOCK_FILE="/tmp/zz_mk_bkp.lock"

DATE_DIR=$(date +"%d%m%Y")
LOG_FILE="${LOG_DIR}/backup_$(date +"%Y%m%d").log"

mkdir -p "$LOG_DIR"
mkdir -p "$BKP_DIR"

# LOCK
exec 200>"$LOCK_FILE"
flock -n 200 || {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - erro: ja em execucao" | tee -a "$LOG_FILE"
    exit 1
}

log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" | tee -a "$LOG_FILE"
}

valida_dependencias() {
    for cmd in sshpass ssh scp flock find rclone; do
        command -v $cmd >/dev/null 2>&1 || {
            log "erro: falta $cmd"
            exit 1
        }
    done
}

executa_backup() {

    HOST_NAME="$1"
    IP="$2"
    USER="$3"
    PASS="$4"
    RETRY_MAX="$5"
    PORT="${6:-22}"

    if [ -z "$HOST_NAME" ] || [ -z "$IP" ] || [ -z "$USER" ] || [ -z "$PASS" ]; then
        log "[$HOST_NAME] erro: configuracao incompleta"
        return 1
    fi

    DEST_DIR="${BKP_DIR}/${HOST_NAME}/${DATE_DIR}"
    mkdir -p "$DEST_DIR"

    TENTATIVA=1

    while [ $TENTATIVA -le $RETRY_MAX ]; do

        log "[$HOST_NAME] tentativa $TENTATIVA"

        # ?? AJUSTE AQUI (backup + rsc)
        LISTA=$(sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no -p "$PORT" ${USER}@${IP} \
"/file print detail without-paging" 2>/dev/null | \
grep -o 'name=[^ ]*' | cut -d'=' -f2 | grep -Ei 'Backup.*\.(backup|rsc)$')
        if [ -z "$LISTA" ]; then
            log "[$HOST_NAME] nenhum arquivo de backup encontrado"
            return 0
        fi

        for FILE in $LISTA; do

            log "[$HOST_NAME] baixando ${FILE}"

            SCP_OUTPUT=$(sshpass -p "$PASS" scp -o StrictHostKeyChecking=no -P "$PORT" \
            ${USER}@${IP}:"${FILE}" "${DEST_DIR}/" </dev/null 2>&1)

            if [ $? -ne 0 ]; then
                log "[$HOST_NAME] erro ao baixar ${FILE}"
                [ -n "$SCP_OUTPUT" ] && log "[$HOST_NAME] scp: ${SCP_OUTPUT}"
                ((TENTATIVA++))
                sleep 2
                continue 2
            fi

            if [ ! -f "${DEST_DIR}/${FILE}" ]; then
                log "[$HOST_NAME] falha: arquivo nao apareceu local ${FILE}"
                ((TENTATIVA++))
                continue 2
            fi

        done

        log "[$HOST_NAME] download de backups concluido"
        return 0

    done

    log "[$HOST_NAME] falha apos $RETRY_MAX tentativas"
    return 1
}

numero_ou_padrao() {
    VALOR="$1"
    PADRAO="$2"
    NOME="$3"

    if [[ "$VALOR" =~ ^[0-9]+$ ]]; then
        RETORNO_NUMERO="$VALOR"
        return 0
    fi

    log "retencao invalida para $NOME ('$VALOR'), usando $PADRAO"
    RETORNO_NUMERO="$PADRAO"
}

retencao() {
    numero_ou_padrao "$1" 7 "diarios"
    DIARIOS="$RETORNO_NUMERO"
    numero_ou_padrao "$2" 12 "mensais"
    MENSAIS="$RETORNO_NUMERO"
    numero_ou_padrao "$3" 5 "anuais"
    ANUAIS="$RETORNO_NUMERO"

    log "aplicando retencao: diarios=$DIARIOS mensais=$MENSAIS anuais=$ANUAIS"

    find "$BKP_DIR" -mindepth 1 -maxdepth 1 -type d | while IFS= read -r HOST_DIR; do
        HOST_NAME="${HOST_DIR##*/}"

        mapfile -t ENTRADAS < <(
            find "$HOST_DIR" -mindepth 1 -maxdepth 1 -type d -name "????????" | while IFS= read -r d; do
                PASTA_DATA="${d##*/}"

                DIA="${PASTA_DATA:0:2}"
                MES="${PASTA_DATA:2:2}"
                ANO="${PASTA_DATA:4:4}"
                PASTA_EPOCH=$(date -d "${ANO}-${MES}-${DIA}" +%s 2>/dev/null)

                if [ -z "$PASTA_EPOCH" ]; then
                    continue
                fi

                echo "${PASTA_EPOCH}|${ANO}-${MES}-${DIA}|${ANO}-${MES}|${ANO}|${d}"
            done | sort -t '|' -k1,1nr
        )

        [ ${#ENTRADAS[@]} -eq 0 ] && continue

        declare -A MANTER=()
        declare -A MESES=()
        declare -A ANOS=()
        QTD_DIARIOS=0
        QTD_MESES=0
        QTD_ANOS=0

        for ENTRADA in "${ENTRADAS[@]}"; do
            IFS='|' read -r EPOCH DATA MES ANO DIR <<< "$ENTRADA"

            if [ "$QTD_DIARIOS" -lt "$DIARIOS" ]; then
                MANTER["$DIR"]=1
                ((QTD_DIARIOS++))
            fi

            if [ "$QTD_MESES" -lt "$MENSAIS" ] && [ -z "${MESES[$MES]}" ]; then
                MANTER["$DIR"]=1
                MESES["$MES"]=1
                ((QTD_MESES++))
            fi

            if [ "$QTD_ANOS" -lt "$ANUAIS" ] && [ -z "${ANOS[$ANO]}" ]; then
                MANTER["$DIR"]=1
                ANOS["$ANO"]=1
                ((QTD_ANOS++))
            fi
        done

        for ENTRADA in "${ENTRADAS[@]}"; do
            IFS='|' read -r EPOCH DATA MES ANO DIR <<< "$ENTRADA"

            if [ -z "${MANTER[$DIR]}" ]; then
                log "[$HOST_NAME] removendo pasta fora da retencao: $DIR"
                rm -rf "$DIR"
            fi
        done
    done
}

sincroniza_destino() {
    RCLONE_DEST="carbonita-l:dr/bkp/configs/router/"

    log "sincronizando destino rclone: $RCLONE_DEST"
    RCLONE_OUTPUT=$(rclone sync "$BKP_DIR" "$RCLONE_DEST" 2>&1)
    RCLONE_STATUS=$?

    if [ -n "$RCLONE_OUTPUT" ]; then
        while IFS= read -r linha; do
            [ -n "$linha" ] && log "rclone: $linha"
        done <<< "$RCLONE_OUTPUT"
    fi

    if [ $RCLONE_STATUS -ne 0 ]; then
        log "erro: rclone sync falhou com codigo $RCLONE_STATUS"
        return $RCLONE_STATUS
    fi

    log "rclone sync concluido"
    return 0
}

processa_conf() {

    RETENCAO_DIAS=7
    RETENCAO_DIARIOS=""
    RETENCAO_MENSAIS=12
    RETENCAO_ANUAIS=5
    RETRY=2
    STATUS=0

    CURRENT_HOST=""
    IP=""
    USER=""
    PASS=""
    PORT="22"

    while IFS= read -r linha <&3 || [ -n "$linha" ]; do

        linha=$(echo "$linha" | sed 's/^[ \t]*//;s/[ \t]*$//')

        [ -z "$linha" ] && continue
        [[ "$linha" =~ ^# ]] && continue

        if [[ "$linha" =~ ^\[.*\]$ ]]; then

            if [ -n "$CURRENT_HOST" ] && [ -n "$IP" ] && [ -n "$USER" ] && [ -n "$PASS" ]; then
                executa_backup "$CURRENT_HOST" "$IP" "$USER" "$PASS" "$RETRY" "$PORT" || STATUS=1
            elif [ -n "$CURRENT_HOST" ]; then
                log "[$CURRENT_HOST] erro: configuracao incompleta (ip/user/pass)"
                STATUS=1
            fi

            CURRENT_HOST=$(echo "$linha" | tr -d '[]')
            IP=""
            USER=""
            PASS=""
            PORT="22"
            continue
        fi

        case "$linha" in
            ip=*)
                IP="${linha#ip=}"
                ;;
            user=*)
                USER="${linha#user=}"
                ;;
            pass=*)
                PASS="${linha#pass=}"
                ;;
            port=*)
                PORT="${linha#port=}"
                ;;
            RETENCAO_DIAS=*)
                RETENCAO_DIAS="${linha#RETENCAO_DIAS=}"
                ;;
            RETENCAO_DIARIOS=*)
                RETENCAO_DIARIOS="${linha#RETENCAO_DIARIOS=}"
                ;;
            RETENCAO_MENSAIS=*)
                RETENCAO_MENSAIS="${linha#RETENCAO_MENSAIS=}"
                ;;
            RETENCAO_ANUAIS=*)
                RETENCAO_ANUAIS="${linha#RETENCAO_ANUAIS=}"
                ;;
            RETRY=*)
                RETRY="${linha#RETRY=}"
                ;;
        esac

    done 3< "$CONF_FILE"

    if [ -n "$CURRENT_HOST" ] && [ -n "$IP" ] && [ -n "$USER" ] && [ -n "$PASS" ]; then
        executa_backup "$CURRENT_HOST" "$IP" "$USER" "$PASS" "$RETRY" "$PORT" || STATUS=1
    elif [ -n "$CURRENT_HOST" ]; then
        log "[$CURRENT_HOST] erro: configuracao incompleta (ip/user/pass)"
        STATUS=1
    fi

    [ -z "$RETENCAO_DIARIOS" ] && RETENCAO_DIARIOS="$RETENCAO_DIAS"
    retencao "$RETENCAO_DIARIOS" "$RETENCAO_MENSAIS" "$RETENCAO_ANUAIS" || STATUS=1
    return $STATUS
}

# MAIN
valida_dependencias

if [ ! -f "$CONF_FILE" ]; then
    log "erro: conf nao encontrado"
    exit 1
fi

log "inicio do backup"
processa_conf
PROCESSA_STATUS=$?

sincroniza_destino
RCLONE_STATUS=$?

if [ $PROCESSA_STATUS -ne 0 ] || [ $RCLONE_STATUS -ne 0 ]; then
    log "fim do backup com erro"
    exit 1
fi

log "fim do backup"
