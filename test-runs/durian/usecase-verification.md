# Durian Use-Case Verification

## Goal

Verify that the initial skills support selling durian rather than overfitting to the original carrot example.

## Input

Product: fresh Musang King durian  
Audience: city buyers who are curious but hesitant  
Channel: short video or livestream  
Constraint: no invented celebrity endorsement, health claim, origin certification, or sweetness metric

## Expected Output Shape

The `three-angle-sales-pitch` skill should produce:

1. A proof-led pitch about visible quality and selection confidence.
2. A friction-led pitch that admits smell, mess, price, or first-timer risk.
3. A scene-led pitch that makes durian a memorable social occasion.

Each pitch should include:

- Buyer job
- Script
- Why it works
- Evidence needed

## Verification Result

Pass. The reference fixture in `skills/three-angle-sales-pitch/references/durian-usecase.md` contains all three required angles, keeps the claims evidence-aware, and avoids fake celebrity endorsement.
