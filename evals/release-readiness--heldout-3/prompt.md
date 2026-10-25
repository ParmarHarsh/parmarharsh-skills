---
max_turns: 6
timeout_seconds: 300
allowed_tools: [Read, Glob, Grep, Skill]
tags: [collision, trigger]
plugins: ["../../plugins/dogfood-bug-report", "../../plugins/phase-brief", "../../plugins/release-readiness"]
---

do a release readiness pass on this before i deploy to production - env config, migrations, error handling, whatever matters - and end with a clear ship / dont ship call
