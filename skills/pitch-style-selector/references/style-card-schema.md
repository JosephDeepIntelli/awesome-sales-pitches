# Style Card Schema

Each style card defines one selectable pitch mechanism. A style card should be reusable across products without relying on a celebrity name or copied expression.

## Required Fields

Use these exact lowercase field labels so `scripts/validate-skills.sh` can verify the card:

```yaml
style_id:
display_name:
inspired_by:
source_safety:
best_for:
avoid_when:
formula:
evidence_strategy:
evidence_needed:
durian_example:
verification_test:
```

## Naming Rules

- `style_id` uses lowercase hyphen-case.
- `display_name` names the persuasion mechanism, not a person or brand.
- `inspired_by` may say `source-agnostic` or mention a broad source category like `founder keynote patterns`; avoid celebrity names unless there is a documented public-domain or licensed reason.
- Do not use `style`, `voice`, `clone`, or `as [person]` language.

## Adding a New Style

1. Distill the mechanism from a source speech.
2. Name the mechanism neutrally.
3. Write a formula that does not depend on source wording.
4. Write an `evidence_strategy` that tells the selector whether to search, ask, or use supplied facts before writing.
5. Add a durian example to prove the style transfers.
6. Add an evidence checklist that catches risky claims.
