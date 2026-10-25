---
max_turns: 6
timeout_seconds: 300
allowed_tools: [Read, Glob, Grep, Skill]
tags: [collision, trigger]
plugins: ["../../plugins/dogfood-bug-report", "../../plugins/phase-brief", "../../plugins/release-readiness"]
---

clean up this bug report before i file it: "search is broken. typing a name with an apostrophe like o'hara returns nothing, sometimes the page just goes blank. pls fix asap"
