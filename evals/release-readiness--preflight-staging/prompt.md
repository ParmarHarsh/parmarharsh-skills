---
max_turns: 6
timeout_seconds: 300
allowed_tools: [Read, Glob, Grep, Skill]
tags: [collision, trigger]
plugins: ["../../plugins/phase-brief", "../../plugins/release-readiness"]
---

run a preflight before we push the pilot build to staging
