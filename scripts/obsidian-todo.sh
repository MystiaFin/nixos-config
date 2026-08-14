#!/usr/bin/env bash

VAULT="$HOME/Obsidian/Site of Grace"
FILE="TODO.md"

# We use 'fish -c' to ensure your shell aliases and themes load.
# The 'exec' inside the string ensures nvim takes over the process.
exec @TERMINAL@ \
    @TERMINAL_FLAGS@ \
    fish -i -c "nvim '$FILE'"
