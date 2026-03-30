#!/bin/bash

BASE_DIR="/etc/scripts/zz_remote_bkp"
CONF_FILE="${BASE_DIR}/zz_remote_bkp.conf"
LOG_DIR="${BASE_DIR}/logs"
BKP_DIR="${BASE_DIR}/bkp"

LOCK_FILE="/tmp/zz_remote_bkp.lock"

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

    # validação forte
    if [ -z "$HOST_NAME" ] || [ -z "$IP" ] || [ -z "$USER" ] || [ -z "$PASS" ]; then
        log "[$HOST_NAME] erro: configuracao incompleta"
        return 1
    fi

    DEST_DIR="${BKP_DIR}/${HOST_NAME}"
    mkdir -p "$DEST_DIR"

    TENTATIVA=1

    while [ $TENTATIVA -le $RETRY_MAX ]; do

        log "[$HOST_NAME] tentativa $TENTATIVA"

        RET=$(sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no -p "$PORT" ${USER}@${IP} "bash -s" </dev/null <<EOF
HOST=\$(hostname)
DATA="${DATE_FMT}"

FILE_MAIN="\${HOST}_\${DATA}.tar.zst"
FILE_CRON="\${HOST}_cron_\${DATA}.tar.zst"

DEST_MAIN="/tmp/\${FILE_MAIN}"
DEST_CRON="/tmp/\${FILE_CRON}"

tar -cf - /root /etc 2>/dev/null | zstd -q -T0 -o "\${DEST_MAIN}"

tar -cf - \
/var/spool/cron \
/etc/crontab \
/etc/cron.d \
/etc/cron.daily \
/etc/cron.hourly \
/etc/cron.weekly \
/etc/cron.monthly 2>/dev/null | zstd -q -T0 -o "\${DEST_CRON}"

if [ ! -f "\${DEST_MAIN}" ] || [ ! -f "\${DEST_CRON}" ]; then
    echo ERRO
    exit 1
fi

echo "\${FILE_MAIN}|\${FILE_CRON}"
EOF
)

        # BLINDAGEM DO RETORNO
        RET=$(echo "$RET" | tr -d '\r')
        RET_LINE=$(echo "$RET" | grep "|" | tail -n1)

        if [[ "$RET_LINE" == "" ]]; then
            log "[$HOST_NAME] erro ao gerar backup"
            ((TENTATIVA++))
            sleep 2
            continue
        fi

        FILE_MAIN=$(echo "$RET_LINE" | cut -d'|' -f1)
        FILE_CRON=$(echo "$RET_LINE" | cut -d'|' -f2)

        for FILE in "$FILE_MAIN" "$FILE_CRON"; do

            REMOTE_FILE="/tmp/${FILE}"

            log "[$HOST_NAME] transferindo ${FILE}"

            sshpass -p "$PASS" scp -o StrictHostKeyChecking=no -P "$PORT" ${USER}@${IP}:"${REMOTE_FILE}" "${DEST_DIR}/" </dev/null

            if [ $? -ne 0 ]; then
                log "[$HOST_NAME] erro no download ${FILE}"
                ((TENTATIVA++))
                sleep 2
                continue 2
            fi

            if [ ! -f "${DEST_DIR}/${FILE}" ]; then
                log "[$HOST_NAME] arquivo nao encontrado local ${FILE}"
                ((TENTATIVA++))
                continue 2
            fi

        done

        sshpass -p "$PASS" ssh -o StrictHostKeyChecking=no -p "$PORT" ${USER}@${IP} "rm -f /tmp/${FILE_MAIN} /tmp/${FILE_CRON}" </dev/null

        log "[$HOST_NAME] backup concluido"
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

    # FD3 isola o conf do stdin — sshpass/ssh/scp nao conseguem consumir as linhas
    while IFS= read -r linha <&3 || [ -n "$linha" ]; do

        linha=$(echo "$linha" | sed 's/^[ \t]*//;s/[ \t]*$//')

        # ignora vazio/comentario
        [ -z "$linha" ] && continue
        [[ "$linha" =~ ^# ]] && continue

        # novo host
        if [[ "$linha" =~ ^\[.*\]$ ]]; then

            # executa host anterior SOMENTE se completo
            if [ -n "$CURRENT_HOST" ] && [ -n "$IP" ] && [ -n "$USER" ] && [ -n "$PASS" ]; then
                executa_backup "$CURRENT_HOST" "$IP" "$USER" "$PASS" "$RETRY" "$PORT"
            elif [ -n "$CURRENT_HOST" ]; then
                log "[$CURRENT_HOST] erro: configuracao incompleta (ip/user/pass)"
            fi

            # inicia novo host
            CURRENT_HOST=$(echo "$linha" | tr -d '[]')
            IP=""
            USER=""
            PASS=""
            PORT="22"
            continue
        fi

        # leitura dos campos
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

    # ultimo host
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
