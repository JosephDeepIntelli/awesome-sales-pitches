<div align="center">

# Awesome Sales Pitches

### A skill-first library that turns famous sales speeches into reusable, evidence-aware pitch moves — without copying the source.

[![Skill format](https://img.shields.io/badge/format-Agent%20Skills-blue.svg)](#skills)
[![Codex compatible](https://img.shields.io/badge/codex-compatible-black.svg)](#1-install-the-skills)
[![Claude Code compatible](https://img.shields.io/badge/claude%20code-compatible-orange.svg)](#1-install-the-skills)
[![Rights-boundary aware](https://img.shields.io/badge/rights--boundary-enforced-darkgreen.svg)](#rights-boundary)

</div>

## Why this repo?

Most "great pitch" collections are quote libraries. You can't reuse a quote — you can only quote it.

This repo treats famous speeches, livestream scripts, ads, and short-video hooks as **structural evidence** for reusable pitch *mechanisms*. Every skill here teaches an agent how to:

- Distill a speech into a named, portable pattern.
- Apply one selected pitch style to a real product.
- Mark every claim that still needs proof before publishing.
- Stay on the right side of the rights boundary — no fake endorsements, no copied wording.

The default output contract is **one selected style**, not a batch of every angle.

## Skills

| Skill | What it does |
| --- | --- |
| [`pitch-style-selector`](skills/pitch-style-selector/) | Load one neutral pitch style from the catalog and apply it to your offer. |
| [`pitch-pattern-distiller`](skills/pitch-pattern-distiller/) | Turn a reference speech into a reusable pattern card you can add to the catalog. |

## Starter styles

| Style ID | Mechanism | Best for |
| --- | --- | --- |
| [`proof-ladder`](skills/pitch-style-selector/references/styles/proof-ladder.md) | Trust through visible proof and quality criteria | Expensive, unfamiliar, quality-variable products |
| [`honest-friction`](skills/pitch-style-selector/references/styles/honest-friction.md) | Conversion through direct objection handling | Products with obvious resistance — smell, mess, first-timer risk |
| [`occasion-spark`](skills/pitch-style-selector/references/styles/occasion-spark.md) | Desire through a memorable social scene | Taste, gift, hospitality, or memory-driven products |

All cards live under [`skills/pitch-style-selector/references/styles/`](skills/pitch-style-selector/references/styles/) and follow the [style card schema](skills/pitch-style-selector/references/style-card-schema.md).

## Quick Start

### 1. Install the skills

**Claude Code** — install as a plugin (recommended). The repo ships a [`.claude-plugin/plugin.json`](.claude-plugin/plugin.json) so it works with `/plugin` straight from a local clone or a marketplace:

```bash
git clone <this-repo> awesome-sales-pitches
/plugin install ./awesome-sales-pitches    # inside a Claude Code session
```

**Codex CLI** — copy or symlink the skill folders:

```bash
cp -r skills/* ~/.codex/skills/
# or, to track updates:
ln -s "$PWD/skills/pitch-style-selector"   ~/.codex/skills/
ln -s "$PWD/skills/pitch-pattern-distiller" ~/.codex/skills/
```

**Any other Anthropic-style runtime** — copy `skills/*` into the runtime's skill directory. Each skill is self-contained.

### 2. Pick a style and pin an offer

```text
Use pitch-style-selector with style=proof-ladder.
Product:  fresh Musang King durian
Buyer:    city customer, curious but hesitant
Channel:  short video, 45 seconds
Evidence: opening footage, replacement policy
```

### 3. Read the output

The skill returns one pitch in spoken language, plus an evidence checklist for everything still unverified.

#### Example output — `proof-ladder` · durian

> If this is your first serious durian, do not buy on price alone. Look at the flesh: deep yellow, creamy, not watery, opened at the ripe window. We show the tray before packing so you can judge the texture before you pay. Start with one portion and compare the first bite against what cheap random stalls usually give you.

**Evidence still needed before publishing:** product variety, origin, packing time, quality footage, guarantee, replacement policy, price basis.

## How a style is built

A style card is a YAML block inside a Markdown file. The schema is in [`style-card-schema.md`](skills/pitch-style-selector/references/style-card-schema.md). Required fields:

```yaml
style_id:
display_name:
inspired_by:
source_safety:
best_for:
avoid_when:
formula:
evidence_needed:
durian_example:
verification_test:
```

To contribute a new style:

1. Distill the mechanism from a source speech with `pitch-pattern-distiller`.
2. Name the mechanism neutrally — no celebrity, no brand.
3. Write a durian example to prove the style transfers across products.
4. Add an evidence checklist that catches risky claims (origin, health, performance, authority).
5. Run the validator.

## Verify

```bash
scripts/validate-skills.sh
```

The script checks that:

- Every skill passes the Codex skill-creator quick check.
- No template placeholder (`TODO`, `[TODO`) leaks into production.
- Every style card carries all required fields.
- No display name borrows celebrity or brand authority.
- The durian fixture still references all three starter styles.

## Repo layout

```
awesome-sales-pitches/
├── .claude-plugin/
│   └── plugin.json                    Claude Code plugin manifest
├── AGENTS.md                          Repo rules — read before contributing
├── README.md
├── scripts/
│   └── validate-skills.sh             Skill + style-card validator (portable)
├── skills/
│   ├── pitch-pattern-distiller/
│   │   ├── SKILL.md
│   │   ├── agents/openai.yaml
│   │   └── references/pattern-card-rubric.md
│   └── pitch-style-selector/
│       ├── SKILL.md
│       ├── agents/openai.yaml
│       └── references/
│           ├── style-card-schema.md
│           └── styles/                Selectable pitch styles
│               ├── proof-ladder.md
│               ├── honest-friction.md
│               └── occasion-spark.md
├── docs/
│   └── superpowers/plans/             Implementation plans
└── test-runs/
    └── durian/                        Validation fixture
```

## Rights boundary

This repo is intentionally restrained about how it uses source material:

- Famous or celebrity speeches are sources for **structure**, never copy to reuse.
- Style names describe **mechanisms**, not people.
- No invented endorsements, origin claims, health claims, or performance statistics.
- A source may be cited in internal analysis, but the user-facing pitch must stand on its own evidence.

These rules are enforced by both [`AGENTS.md`](AGENTS.md) and `scripts/validate-skills.sh`. PRs that violate them won't merge.

## Contributing

1. Read [`AGENTS.md`](AGENTS.md) — short and binding.
2. Add a new style card or pattern card with a concrete example that proves transfer.
3. Run `scripts/validate-skills.sh` until it prints `All skill checks passed.`
4. Open a PR. In the description, name the source speech (publicly available, please) and the mechanism you distilled.

## License

Not yet licensed. Until a LICENSE file lands, treat the contents as the contributors' work — open an issue before using a style card in a production campaign.
