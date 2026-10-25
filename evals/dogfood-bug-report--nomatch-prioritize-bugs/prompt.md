---
max_turns: 6
timeout_seconds: 300
allowed_tools: [Read, Glob, Grep, Skill]
tags: [collision, near-miss]
plugins: ["../../plugins/dogfood-bug-report", "../../plugins/phase-brief", "../../plugins/release-readiness"]
---

we have three open bugs: login emails arrive 10 minutes late, the csv export drops the last row, and the avatar upload rejects png files over 2 mb. which should we fix first and why? two sentences each
