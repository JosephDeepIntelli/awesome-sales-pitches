#!/usr/bin/env bash
# Portable validator for awesome-sales-pitches.
# Works on any machine with bash + grep + awk. The Codex skill-creator
# quick_validate.py runs as an extra check only when installed.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CODEX_VALIDATOR="${CODEX_VALIDATOR:-$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py}"

fail() { echo "FAIL: $1" >&2; exit 1; }
pass() { echo "ok   $1"; }
note() { echo "note $1"; }

# 1) Every skill folder has SKILL.md with required frontmatter and a
#    name that matches the directory.
for skill in "$ROOT"/skills/*; do
  [ -d "$skill" ] || continue
  name="$(basename "$skill")"
  skill_md="$skill/SKILL.md"

  [ -f "$skill_md" ] || fail "Missing SKILL.md in $skill"
  grep -q "^name:" "$skill_md" || fail "$skill_md missing 'name:' frontmatter"
  grep -q "^description:" "$skill_md" || fail "$skill_md missing 'description:' frontmatter"

  declared="$(awk -F': *' '/^name:/{print $2; exit}' "$skill_md" | tr -d '"')"
  [ "$declared" = "$name" ] \
    || fail "$skill_md frontmatter name '$declared' does not match folder '$name'"

  pass "skill: $name"
done

# 2) Optional: Codex skill-creator deep validation, when available.
if [ -x "$CODEX_VALIDATOR" ] && command -v python3 >/dev/null 2>&1; then
  for skill in "$ROOT"/skills/*; do
    [ -d "$skill" ] || continue
    python3 "$CODEX_VALIDATOR" "$skill"
  done
else
  note "Codex skill-creator validator not found; skipping deep checks (set CODEX_VALIDATOR=/path/to/quick_validate.py to enable)."
fi

# 3) No template placeholders leak into shipped content.
#    Matches real template markers like `[TODO:`, `[TODO ]`, or `{{NAME}}`,
#    not casual prose mentions of the word "todo".
if grep -RInE --binary-files=without-match \
    '\[TODO[: ]|\{\{[A-Z_][A-Z0-9_]*\}\}' \
    "$ROOT/skills" "$ROOT/README.md" "$ROOT/AGENTS.md" "$ROOT/test-runs"; then
  fail "Template placeholders remain (see above)."
fi

# 4) Style cards carry every required field and use neutral display names.
STYLE_DIR="$ROOT/skills/pitch-style-selector/references/styles"
required_fields=(
  style_id
  display_name
  inspired_by
  source_safety
  best_for
  avoid_when
  formula
  evidence_needed
  durian_example
  verification_test
)

shopt -s nullglob
cards=("$STYLE_DIR"/*.md)
[ ${#cards[@]} -gt 0 ] || fail "No style cards found in $STYLE_DIR"

for card in "${cards[@]}"; do
  for field in "${required_fields[@]}"; do
    grep -q "^$field:" "$card" || fail "Missing field '$field:' in $card"
  done

  display_name="$(grep "^display_name:" "$card" | head -n 1 | cut -d: -f2- | sed 's/^ *//')"
  if echo "$display_name" | grep -Eqi "celebrity|steve jobs|dong yuhui|luo yonghao|elon musk|jobs|bezos|tesla|apple"; then
    fail "Display name borrows source/celebrity authority in $card: $display_name"
  fi

  pass "style card: $(basename "$card")"
done

# 5) Skill contracts and durian fixture stay in sync.
grep -q "style=proof-ladder" "$ROOT/skills/pitch-style-selector/agents/openai.yaml" \
  || fail "openai.yaml default_prompt missing proof-ladder example"
grep -q "one selected style" "$ROOT/skills/pitch-style-selector/SKILL.md" \
  || fail "pitch-style-selector SKILL.md missing 'one selected style' contract"

fixture="$ROOT/test-runs/durian/usecase-verification.md"
[ -f "$fixture" ] || fail "Missing durian fixture: $fixture"
for style in proof-ladder honest-friction occasion-spark; do
  grep -q "$style" "$fixture" || fail "Fixture $fixture missing reference to $style"
done
pass "durian fixture references all starter styles"

# 6) Claude Code plugin manifest, if present, has the minimum required fields.
manifest="$ROOT/.claude-plugin/plugin.json"
if [ -f "$manifest" ]; then
  grep -q '"name"' "$manifest" || fail "$manifest missing 'name' field"
  pass "plugin manifest: .claude-plugin/plugin.json"
fi

echo "All skill checks passed."
