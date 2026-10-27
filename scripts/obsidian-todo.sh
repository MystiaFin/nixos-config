#!/usr/bin/env bash

VAULT="$HOME/Obsidian/Site of Grace"
FILE="TODO.md"

# We use 'zsh -i -c' to ensure your shell aliases and themes load.
# The 'exec' inside the string ensures nvim takes over the process.
exec @TERMINAL@ \
    @TERMINAL_FLAGS@ \
    zsh -i -c "nvim '$FILE'"
