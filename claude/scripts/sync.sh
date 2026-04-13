#!/usr/bin/env bash
set -euo pipefail

REPO="https://github.com/sans-github/agents"
REF="${1:-main}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP=$(mktemp -d)

echo "Syncing agents from $REPO@$REF..."

git clone --depth=1 --branch "$REF" "$REPO" "$TMP" -q

for item in agents rules skills template GETTING-STARTED.md tech-custom-config.md; do
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

if [ -f "$TMP/README.md" ]; then
  cp "$TMP/README.md" "$ROOT/.claude/agents-guide.md"
  echo "  README.md -> .claude/agents-guide.md"
else
  echo "  WARN: README.md not found in upstream, skipping"
fi

rm -rf "$TMP"
echo "Done."
