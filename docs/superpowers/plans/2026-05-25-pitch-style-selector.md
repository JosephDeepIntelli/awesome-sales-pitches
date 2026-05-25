# Pitch Style Selector Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace batch three-angle output with a selectable pitch-style system that can grow with celebrity-inspired but copyright-safe pitch patterns.

**Architecture:** Add one primary `pitch-style-selector` skill. Store each reusable pitch style as a separate reference card under `references/styles/`, with neutral display names and source-safe constraints. Keep `pitch-pattern-distiller` as the skill for turning future famous speeches into new style cards.

**Tech Stack:** Markdown Codex skills, YAML frontmatter, Bash validation.

---

### Task 1: Add Selectable Style Skill

**Files:**
- Create: `skills/pitch-style-selector/SKILL.md`
- Create: `skills/pitch-style-selector/agents/openai.yaml`
- Create: `skills/pitch-style-selector/references/style-card-schema.md`
- Create: `skills/pitch-style-selector/references/styles/proof-ladder.md`
- Create: `skills/pitch-style-selector/references/styles/honest-friction.md`
- Create: `skills/pitch-style-selector/references/styles/occasion-spark.md`

- [ ] Initialize `pitch-style-selector` with the skill creator template.
- [ ] Write `SKILL.md` so it outputs one selected style by default.
- [ ] Add schema fields for `style_id`, `display_name`, `best_for`, `formula`, `avoid`, `evidence_needed`, `durian_example`, and `source_safety`.
- [ ] Convert the three durian angles into separate neutral style cards.

### Task 2: Retire Batch Skill

**Files:**
- Delete: `skills/three-angle-sales-pitch/SKILL.md`
- Delete: `skills/three-angle-sales-pitch/agents/openai.yaml`
- Delete: `skills/three-angle-sales-pitch/references/durian-usecase.md`
- Modify: `README.md`
- Modify: `AGENTS.md`
- Modify: `test-runs/durian/usecase-verification.md`

- [ ] Remove the batch-output skill to avoid accidental three-angle responses.
- [ ] Update docs to say users choose one style unless they request comparison.
- [ ] Point durian verification to the three selectable style cards.

### Task 3: Validate Style Cards

**Files:**
- Modify: `scripts/validate-skills.sh`

- [ ] Validate both skill folders with `quick_validate.py`.
- [ ] Fail if any template placeholder remains.
- [ ] Fail if a style card lacks required fields.
- [ ] Fail if a style card display name includes celebrity/source wording.
- [ ] Run `scripts/validate-skills.sh` and commit the redesign.
