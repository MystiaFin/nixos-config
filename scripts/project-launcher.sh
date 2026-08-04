#!/usr/bin/env bash
TERMINAL="${TERMINAL:-foot}"
SESSION_FILE="${XDG_RUNTIME_DIR:-/tmp}/tmux-rofi-session"
THEME="$HOME/.config/scripts/project-launcher-theme.rasi"

if ! tmux list-sessions 2>/dev/null | grep -q .; then
    notify-send "project-launcher" "No tmux sessions found." 2>/dev/null || true
    exit 0
fi

CHOSEN=$(tmux list-sessions -F "#{session_name}" \
    | rofi -dmenu \
           -p " " \
           -i \
           -no-custom \
           -theme "$THEME")

[[ -z "$CHOSEN" ]] && exit 0

echo "$CHOSEN" > "$SESSION_FILE"

exec "$TERMINAL" -a foot -T foot -o colors.alpha=0.9 -- fish -i -c "exec tmux attach-session -t '$CHOSEN'"
