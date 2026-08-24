find . -type f -name '*.nix' -print0 | while IFS= read -r -d '' file; do
  echo
  echo "===== $file ====="
  cat "$file"
done > nixos-config-dump.txt
