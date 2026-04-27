#!/bin/bash

BASE_DIR="/etc/scripts/zz_mk_bkp"
CONF_FILE="${BASE_DIR}/zz_mk_bkp.conf"
LOG_DIR="${BASE_DIR}/logs"
BKP_DIR="${BASE_DIR}/bkp"

LOCK_FILE="/tmp/zz_mk_bkp.lock"

DATE_FMT=$(date +"%d%m%y_%H%M")
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
    for cmd in sshpass ssh scp zstd tar flock; do
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

    DEST_DIR="${BKP_DIR}/${HOST_NAME}"
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

            sshpass -p "$PASS" scp -o StrictHostKeyChecking=no -P "$PORT" \
            ${USER}@${IP}:"${FILE}" "${DEST_DIR}/" </dev/null

            if [ $? -ne 0 ]; then
                log "[$HOST_NAME] erro ao baixar ${FILE}"
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

    find "$BKP_DIR" -type f -name "*.zst" -mtime +$DIAS | while read f; do
        log "removendo antigo: $f"
        rm -f "$f"
    done
}

processa_conf() {

    RETENCAO=7
    RETRY=2

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
                executa_backup "$CURRENT_HOST" "$IP" "$USER" "$PASS" "$RETRY" "$PORT"
            elif [ -n "$CURRENT_HOST" ]; then
                log "[$CURRENT_HOST] erro: configuracao incompleta (ip/user/pass)"
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
        executa_backup "$CURRENT_HOST" "$IP" "$USER" "$PASS" "$RETRY" "$PORT"
    elif [ -n "$CURRENT_HOST" ]; then
        log "[$CURRENT_HOST] erro: configuracao incompleta (ip/user/pass)"
    fi

    retencao "$RETENCAO"
}

# MAIN
valida_dependencias

if [ ! -f "$CONF_FILE" ]; then
    log "erro: conf nao encontrado"
    exit 1
fi

log "inicio do backup"
processa_conf
log "fim do backup"