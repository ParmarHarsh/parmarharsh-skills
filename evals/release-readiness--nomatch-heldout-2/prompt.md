---
max_turns: 6
timeout_seconds: 300
allowed_tools: [Read, Glob, Grep, Skill]
tags: [collision, near-miss]
plugins: ["../../plugins/dogfood-bug-report", "../../plugins/phase-brief", "../../plugins/release-readiness"]
---

prod is throwing 502s since the deploy an hour ago, help me figure out whats wrong
