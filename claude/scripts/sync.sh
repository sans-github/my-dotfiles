#!/usr/bin/env bash
set -euo pipefail

REPO="https://github.com/sans-github/agents"
REF="${1:-main}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP=$(mktemp -d)

echo "Syncing agents from $REPO@$REF..."

git clone --depth=1 --branch "$REF" "$REPO" "$TMP" -q

for item in agents rules skills template GETTING-STARTED.md CONVENTIONS.md; do
  src="$TMP/.claude/$item"
  dst="$ROOT/.claude/$item"
  if [ -e "$src" ]; then
    rm -rf "$dst"
    cp -r "$src" "$dst"
    echo "  $item -> .claude/$item"
  else
    echo "  WARN: .claude/$item not found in upstream, skipping"
  fi
done

rm -rf "$TMP"
echo "Done."