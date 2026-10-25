---
max_turns: 6
timeout_seconds: 300
allowed_tools: [Read, Glob, Grep, Skill]
tags: [collision, near-miss]
plugins: ["../../plugins/dogfood-bug-report", "../../plugins/phase-brief", "../../plugins/release-readiness"]
---

getting TypeError: Cannot read properties of undefined (reading 'trim') at validateTitle (src/notes/validate.js:18) when i save a note with an empty title. why does this happen and how do i fix it?
