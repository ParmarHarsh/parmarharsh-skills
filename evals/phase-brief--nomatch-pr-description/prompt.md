---
max_turns: 6
timeout_seconds: 300
allowed_tools: [Read, Glob, Grep, Skill]
tags: [collision, near-miss]
plugins: ["../../plugins/dogfood-bug-report", "../../plugins/phase-brief", "../../plugins/release-readiness"]
---

write a PR description for this: added a per-IP rate limit to signup and password reset, new env var RATE_LIMIT_PER_MIN (default 5), tests added for both routes
