#!/bin/bash
#
# zz_copy.sh
#
# Copia diretórios utilizando rsync
#

############################
# CONFIGURAÇÕES
############################

ORIGEM="/work/dados/Main/Midia"
DESTINO="/work/dados/h265"

LOG="/var/log/zz_copy.log"

# Diretórios a copiar
DIR1="Desenhos"
DIR2="Filmes"

############################
# FUNÇÕES
############################

log()
{
    MSG="$1"

    echo "$(date '+%Y-%m-%d %H:%M:%S') - $MSG" | tee -a "$LOG"
}

verifica_diretorio()
{
    DIR="$1"

    if [ ! -d "$DIR" ]; then
        log "ERRO: Diretório não encontrado: $DIR"
        exit 1
    fi
}

cria_destino()
{
    if [ ! -d "$DESTINO" ]; then
        mkdir -p "$DESTINO"
        log "Diretório criado: $DESTINO"
    fi
}

copiar()
{
    PASTA="$1"

    log "Iniciando cópia de $PASTA"

    rsync -aH --info=progress2 \
        "$ORIGEM/$PASTA" \
        "$DESTINO/" \
        >> "$LOG" 2>&1

    RET="$?"

    if [ "$RET" -eq 0 ]; then
        log "Cópia concluída: $PASTA"
    else
        log "ERRO ao copiar: $PASTA"
        return 1
    fi
}

############################
# INÍCIO
############################

log "======================================="
log "Início da execução"

verifica_diretorio "$ORIGEM"
cria_destino

copiar "$DIR1"
copiar "$DIR2"

log "Fim da execução"
log "======================================="
