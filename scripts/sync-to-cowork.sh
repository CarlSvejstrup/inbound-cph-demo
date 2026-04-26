#!/bin/bash
# sync-to-cowork.sh
# Pulls latest from main and symlinks each skill into the local Cowork skills folder.
# Intended to run on a LaunchAgent timer or manually by power users.

set -euo pipefail

REPO_DIR="${INBOUND_DEMO_DIR:-$HOME/code/personal/inbound-cph-demo}"
COWORK_SKILLS_DIR="${COWORK_SKILLS_DIR:-$HOME/Library/Application Support/Claude/skills}"

if [[ ! -d "$REPO_DIR" ]]; then
  echo "Error: inbound-cph-demo repo not found at $REPO_DIR" >&2
  echo "Set INBOUND_DEMO_DIR or clone the repo to that path." >&2
  exit 1
fi

echo "Pulling latest from $REPO_DIR..."
cd "$REPO_DIR"
git pull --ff-only origin main

mkdir -p "$COWORK_SKILLS_DIR"

echo "Symlinking skills into $COWORK_SKILLS_DIR..."
for skill_dir in "$REPO_DIR"/skills/*/; do
  skill_name=$(basename "$skill_dir")
  # Skip template and hidden dirs
  [[ "$skill_name" == _* || "$skill_name" == .* ]] && continue
  target="$COWORK_SKILLS_DIR/$skill_name"
  if [[ -L "$target" ]]; then
    rm "$target"
  elif [[ -e "$target" ]]; then
    echo "Warning: $target exists and is not a symlink. Skipping." >&2
    continue
  fi
  ln -s "$skill_dir" "$target"
  echo "  linked: $skill_name"
done

echo "Done. $(ls -1 "$COWORK_SKILLS_DIR" | wc -l | tr -d ' ') skills now available in Cowork."
