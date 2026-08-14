#!/usr/bin/env bash
set -euo pipefail

# ── CONFIG ────────────────────────────────────────────────────────────────────
VAULT="$HOME/Obsidian/Site of Grace"
THOUGHTS="$VAULT/Thoughts"

# ── DATE ──────────────────────────────────────────────────────────────────────
TODAY=$(date +%Y-%m-%d)
YEAR=$(date +%Y)
MONTH=$(date +%B)

TARGET_DIR="$THOUGHTS/$YEAR/$MONTH"
TODAY_FILE="$TARGET_DIR/today.md"

# ── ARCHIVE STALE today.md ────────────────────────────────────────────────────
STALE=$(find "$THOUGHTS" -name "today.md" -type f -print -quit 2>/dev/null || true)

if [[ -n "$STALE" ]]; then
    # Grab the standard YYYY-MM-DD for the ID, and DD-MM-YYYY for your filename preference
    STALE_DATE=$(date -r "$STALE" +%Y-%m-%d)
    STALE_FORMATTED_DATE=$(date -r "$STALE" +%d-%m-%Y)

    if [[ "$STALE_DATE" != "$TODAY" ]]; then
        ARCHIVE="$(dirname "$STALE")/${STALE_FORMATTED_DATE}.md"
        
        # ── FRONTMATTER UPDATES ──
        # 1. Update the 'id' from 'today' to the actual date (YYYY-MM-DD)
        # 2. Update the tag from 'today' to 'journal/archived'
        # We write to a temporary file and move it back to ensure compatibility across macOS and Linux
        sed -e "s/^id: today/id: $STALE_DATE/" \
            -e "s/- today/- journal\/archived/" \
            "$STALE" > "${STALE}.tmp" && mv "${STALE}.tmp" "$STALE"

        mv "$STALE" "$ARCHIVE"
    fi
fi

# ── CREATE today.md ───────────────────────────────────────────────────────────
mkdir -p "$TARGET_DIR"

if [[ ! -f "$TODAY_FILE" ]]; then
    cat > "$TODAY_FILE" <<MDEOF
---
date: $TODAY
tags:
  - today
  - journal
aliases: []
id: today
---

# $(date +"%A, %B %-d, %Y")

MDEOF
fi

# ── OPEN ──────────────────────────────────────────────────────────────────────
exec @TERMINAL@ \
    @TERMINAL_FLAGS@ \
    fish -i -c "nvim '$TODAY_FILE'"
