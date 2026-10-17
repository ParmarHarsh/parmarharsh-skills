---
max_turns: 8
timeout_seconds: 600
allowed_tools: [Read, Glob, Grep, Skill]
tags: [near-miss]
---

write a PR description for this: added a per-IP rate limit to signup and password reset, new env var RATE_LIMIT_PER_MIN (default 5), tests added for both routes
