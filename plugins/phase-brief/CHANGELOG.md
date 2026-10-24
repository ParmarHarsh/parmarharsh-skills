# Changelog: phase-brief

## 2.0.0

- Removed the grading mode: it showed no gain over plain Claude (Δ 0 on the eval). The skill now only writes briefs.
- When the code isn't available, the skill writes the full brief with marked placeholders instead of stopping to ask (one CI run in 19 stopped early).

## 1.0.0

- First release.
