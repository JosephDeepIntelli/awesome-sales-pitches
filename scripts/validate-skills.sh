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

STYLE_DIR="$ROOT/skills/pitch-style-selector/references/styles"
required_fields=(
  "style_id:"
  "display_name:"
  "inspired_by:"
  "source_safety:"
  "best_for:"
  "avoid_when:"
  "formula:"
  "evidence_needed:"
  "durian_example:"
  "verification_test:"
)

for card in "$STYLE_DIR"/*.md; do
  [ -f "$card" ] || {
    echo "No style cards found." >&2
    exit 1
  }

  for field in "${required_fields[@]}"; do
    if ! grep -q "^$field" "$card"; then
      echo "Missing required field '$field' in $card" >&2
      exit 1
    fi
  done

  display_name="$(grep "^display_name:" "$card" | head -n 1 | cut -d: -f2- | sed 's/^ *//')"
  if echo "$display_name" | grep -Eqi "celebrity|steve jobs|dong yuhui|luo yonghao|elon musk|jobs|bezos|tesla|apple"; then
    echo "Display name appears source/celebrity-branded in $card: $display_name" >&2
    exit 1
  fi
done

grep -q "style=proof-ladder" "$ROOT/skills/pitch-style-selector/agents/openai.yaml"
grep -q "one selected style" "$ROOT/skills/pitch-style-selector/SKILL.md"
grep -q "proof-ladder" "$ROOT/test-runs/durian/usecase-verification.md"
grep -q "honest-friction" "$ROOT/test-runs/durian/usecase-verification.md"
grep -q "occasion-spark" "$ROOT/test-runs/durian/usecase-verification.md"

echo "All skill checks passed."
