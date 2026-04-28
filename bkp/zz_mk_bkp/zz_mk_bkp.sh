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

retencao() {
    DIAS="$1"
    log "aplicando retencao: $DIAS dias"

    if ! [[ "$DIAS" =~ ^[0-9]+$ ]]; then
        log "retencao invalida '$DIAS', usando 7 dias"
        DIAS=7
    fi

    LIMITE_DATA=$(date -d "$DIAS days ago" +%Y-%m-%d 2>/dev/null)
    LIMITE_EPOCH=$(date -d "$LIMITE_DATA" +%s 2>/dev/null)
    if [ -z "$LIMITE_EPOCH" ]; then
        log "erro: nao foi possivel calcular data de retencao"
        return 1
    fi

    find "$BKP_DIR" -mindepth 2 -maxdepth 2 -type d -name "????????" | while read d; do
        PASTA_DATA="${d##*/}"

        if ! [[ "$PASTA_DATA" =~ ^[0-9]{8}$ ]]; then
            continue
        fi

        DIA="${PASTA_DATA:0:2}"
        MES="${PASTA_DATA:2:2}"
        ANO="${PASTA_DATA:4:4}"
        PASTA_EPOCH=$(date -d "${ANO}-${MES}-${DIA}" +%s 2>/dev/null)

        if [ -z "$PASTA_EPOCH" ]; then
            log "ignorando pasta com data invalida: $d"
            continue
        fi

        if [ "$PASTA_EPOCH" -lt "$LIMITE_EPOCH" ]; then
            log "removendo pasta antiga: $d"
            rm -rf "$d"
        fi
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

    RETENCAO=7
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
                RETENCAO="${linha#RETENCAO_DIAS=}"
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

    retencao "$RETENCAO" || STATUS=1
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
