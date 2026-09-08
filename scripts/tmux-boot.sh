#!/bin/bash

if tmux list-sessions >/dev/null 2>&1; then
    exit 0
fi

tmux new-session -d -s revival

restore_script="$(tmux show-options -gqv @resurrect-restore-script-path)"
if [ -n "$restore_script" ]; then
    tmux run-shell "$restore_script"
fi

tmux kill-session -t revival 2>/dev/null || true
