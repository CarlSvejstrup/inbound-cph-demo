#!/bin/bash
# Build the onboard guide.docx from its markdown source.
# Run this whenever you edit guide.md so users get the new version on /plugin update.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT/plugins/inbound-cph/skills/onboard/templates/guide.md"
OUT="$ROOT/plugins/inbound-cph/skills/onboard/templates/guide.docx"

if ! command -v pandoc >/dev/null 2>&1; then
  echo "Error: pandoc is not installed. Run: brew install pandoc" >&2
  exit 1
fi

pandoc "$SRC" -o "$OUT" --from markdown --to docx
echo "Built: $OUT"
