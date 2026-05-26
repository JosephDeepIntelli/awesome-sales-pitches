---
name: pitch-style-selector
description: "Select and apply one reusable sales pitch style from a growing style-card library. Use when the user asks for a specific pitch style, wants celebrity-inspired or famous-pitch-inspired marketing speech without copying protected expression, or wants one chosen output rather than a batch of multiple angles."
---

# Pitch Style Selector

## Quick Start

Default to **one selected style**. Do not output all available styles unless the user explicitly asks for comparison.

If the user names a style, load that style card from `references/styles/`. If the style is missing or ambiguous, list available style IDs and ask the user to choose one.

Available starter styles:

- `proof-ladder` - trust through visible proof and quality criteria
- `honest-friction` - conversion through direct objection handling
- `occasion-spark` - desire through a memorable social or emotional scene

Read [references/style-card-schema.md](references/style-card-schema.md) before adding a new style card.
Read [references/evidence-supplement.md](references/evidence-supplement.md) when the selected style depends on facts, metrics, comparisons, limitations, or claims that the user has not supplied.

## Workflow

1. **Resolve the style**
   - Accept `style_id`, display name, or close synonym.
   - Load exactly one style card unless comparison is requested.
   - If no style is specified, recommend one style for the product and say why.

2. **Pin the offer**
   - Product or service
   - Target buyer
   - Channel and length
   - Evidence supplied by the user
   - Claims that must stay unverified

3. **Supplement evidence**
   - Follow the selected style card's `evidence_strategy`.
   - Prefer user-supplied facts and primary sources.
   - If current external facts are needed and search is available, search before writing.
   - If search is unavailable, ask for the missing facts instead of inventing them.
   - Keep a short ledger of facts used, source type, and publication or access date when known.

4. **Generate one pitch**
   - Follow the selected style's formula.
   - Keep the script in spoken language.
   - Do not copy source wording, slogans, catchphrases, or celebrity identity.
   - Mark all factual, quality, origin, health, authority, or performance claims that need proof.

5. **Return the output**

```markdown
## [Display Name] Pitch for [Offer]

Style ID: `[style_id]`
Why this style fits:

Evidence used:

Script:

Evidence still missing:

Claims not safe to publish yet:

Use-case verification:
```

## Source-Safety Rules

- Use famous or celebrity pitches as inspiration for structure only.
- Create neutral style names for reusable mechanisms.
- Do not claim endorsement, imitation, affiliation, or "in the voice of" a celebrity.
- Do not reuse memorable protected expression from transcripts, ads, slogans, lyrics, scripts, or speeches.
- A source can be noted for internal analysis, but the user-facing pitch style name should describe the mechanism, not the person.
