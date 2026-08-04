#!/bin/bash

tmux start-server
tmux new-session -d -s revival

TMUX=$( tmux -L default display-message -p '#{socket_path}' 2>/dev/null ) \
    "$HOME/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh"

sleep 3
tmux kill-session -t revival 2>/dev/null
