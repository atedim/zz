#!/bin/bash

# ==================================================
# CONFIGURAÇÃO
# ==================================================

SESSION="monitor_midia"

CMD_P1='du -sh "/work/dados/Main/Midia/Desenhos/" 2>/dev/null'
CMD_P2='du -sh "/work/dados/h265/Desenhos/" 2>/dev/null'
CMD_P3='tail -f /var/log/zz_copy.log'

# ==================================================
# NÃO ALTERAR ABAIXO
# ==================================================

tmux kill-session -t "$SESSION" 2>/dev/null

tmux new-session -d -s "$SESSION"

# Painel 1
tmux send-keys -t "$SESSION":0.0 \
"while true; do clear; echo '=== PAINEL 1 ==='; $CMD_P1; echo; date; sleep 10; done" C-m

# Cria painel inferior
tmux split-window -v -t "$SESSION":0.0

# Volta para o painel superior
tmux select-pane -t "$SESSION":0.0

# Divide superior em dois
tmux split-window -h -t "$SESSION":0.0

# Painel 2
tmux send-keys -t "$SESSION":0.1 \
"while true; do clear; echo '=== PAINEL 2 ==='; $CMD_P2; echo; date; sleep 10; done" C-m

# Painel 3
tmux send-keys -t "$SESSION":0.2 "$CMD_P3" C-m

tmux select-pane -t "$SESSION":0.2
tmux resize-pane -y 15

tmux attach -t "$SESSION"