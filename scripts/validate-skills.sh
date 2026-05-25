#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VALIDATOR="/home/fabian/.codex/skills/.system/skill-creator/scripts/quick_validate.py"

for skill in "$ROOT"/skills/*; do
  [ -d "$skill" ] || continue
  python3 "$VALIDATOR" "$skill"
done

if grep -R "TODO\\|\\[TODO" "$ROOT"/skills "$ROOT"/README.md "$ROOT"/AGENTS.md "$ROOT"/test-runs; then
  echo "Template placeholders remain." >&2
  exit 1
fi

DURIAN="$ROOT/skills/three-angle-sales-pitch/references/durian-usecase.md"
grep -q "Proof Angle" "$DURIAN"
grep -q "Friction Angle" "$DURIAN"
grep -q "Scene Angle" "$DURIAN"
grep -q "fake celebrity" "$DURIAN"

echo "All skill checks passed."
