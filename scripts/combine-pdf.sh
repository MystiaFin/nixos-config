#!/bin/bash

# combine images and pdfs into one pdf next to the first file, in name order
# (the same order thunar shows them in)

if [ "$#" -eq 0 ]; then
    exit 0
fi

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
trap 'notify-send -u critical "Combine into PDF failed" "$(tail -n 3 "$work/log")"' ERR
exec 2>"$work/log"

dir="$(dirname "$1")"
out="$dir/combined.pdf"
n=1
while [ -e "$out" ]; do
    out="$dir/combined-$n.pdf"
    n=$((n + 1))
done

mapfile -t files < <(printf '%s\n' "$@" | sort -V)

pages=()
i=0
for file in "${files[@]}"; do
    i=$((i + 1))
    case "${file,,}" in
        *.pdf)
            pages+=("$file")
            ;;
        *)
            img2pdf "$file" -o "$work/$i.pdf"
            pages+=("$work/$i.pdf")
            ;;
    esac
done

qpdf --warning-exit-0 --empty --pages "${pages[@]}" -- "$out"

notify-send "Combined into PDF" "$(basename "$out") — ${#files[@]} files"
