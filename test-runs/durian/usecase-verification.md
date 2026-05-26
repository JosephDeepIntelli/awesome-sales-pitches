# Durian Use-Case Verification

## Goal

Verify that the initial selectable pitch styles support selling durian rather than overfitting to the original carrot example or forcing a batch output.

## Input

Product: fresh Musang King durian  
Audience: city buyers who are curious but hesitant  
Channel: short video or livestream  
Constraint: no invented celebrity endorsement, health claim, origin certification, or sweetness metric

## Expected Output Shape

The `pitch-style-selector` skill should produce one selected style at a time:

1. `proof-ladder`: a proof-led pitch about visible quality and selection confidence.
2. `honest-friction`: a friction-led pitch that admits smell, mess, price, or first-timer risk.
3. `occasion-spark`: a scene-led pitch that makes durian a memorable social occasion.

Each style card should include:

- Neutral display name
- Formula
- Evidence strategy
- Durian example
- Evidence needed
- Verification test

## Verification Result

Pass. The style cards in `skills/pitch-style-selector/references/styles/` contain all three starter styles, keep claims evidence-aware, declare evidence strategies, avoid celebrity-facing style names, and support one-style output by selection.
