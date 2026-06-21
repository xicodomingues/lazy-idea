#!/usr/bin/env bash
# Dead-Action-ID check — no keystrokes. Diffs every <Action>(id) used in
# modules/ against a saved `:actionlist` dump from the target IDE.
#
# Usage:
#   1. In WebStorm with IdeaVim loaded, run `:actionlist` and save the output
#      to a file (e.g. actionlist.txt).
#   2. ./scripts/check-action-ids.sh actionlist.txt
#
# Exits non-zero and prints any module Action ID the dump doesn't contain.
set -euo pipefail

list="${1:?usage: check-action-ids.sh <saved-actionlist-file>}"
root="$(cd "$(dirname "$0")/.." && pwd)"

missing=()
while read -r id; do
  grep -qiwF -- "$id" "$list" || missing+=("$id")
done < <(grep -rhoE '<Action>\([^)]+\)' "$root/modules" \
           | sed -E 's/<Action>\(([^)]+)\)/\1/' | sort -u)

if ((${#missing[@]})); then
  printf 'MISSING: %s\n' "${missing[@]}"
  echo "${#missing[@]} Action ID(s) not found in $list"
  exit 1
fi
echo "All module Action IDs present in $list ✓"
