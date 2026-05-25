# Repository Guidelines

## Purpose

This repo stores reusable Codex skills for analyzing and applying strong sales speeches. Treat it as a pattern library, not a quote library.

## Structure

- Put Codex skills under `skills/<skill-name>/`.
- Each skill must contain `SKILL.md`.
- Put detailed examples or rubrics under that skill's `references/` directory.
- Put validation artifacts under `test-runs/<case-name>/`.
- Put selectable pitch styles under `skills/pitch-style-selector/references/styles/`.

## Skill Rules

- Keep `SKILL.md` concise and operational.
- Use `references/` for examples that are useful but not always needed.
- Do not include fake celebrity endorsements or unverifiable claims.
- Do not use celebrity or brand names as user-facing pitch style names.
- Output one selected pitch style by default; only compare multiple styles when requested.
- Every applied pitch should list evidence needed before publishing.

## Verification

Run:

```bash
scripts/validate-skills.sh
```

Before committing changes, confirm no skill still contains template placeholders, all style cards pass schema checks, and the durian fixture still passes the local checks.
