#!/usr/bin/env bash

VAULT_DIR="$HOME/Obsidian/Site of Grace"
FILE="TODO.md"

# We use 'fish -c' to ensure your shell aliases and themes load.
# The 'exec' inside the string ensures nvim takes over the process.
exec kitty \
    --directory "$VAULT_DIR" \
    --class "obsidian-todo" \
    -T "Obsidian TODO" \
    -o background_opacity=0.9 \
    fish -i -c "nvim '$FILE'"
