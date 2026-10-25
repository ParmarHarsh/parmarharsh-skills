---
max_turns: 6
timeout_seconds: 300
allowed_tools: [Read, Glob, Grep, Skill]
tags: [collision, near-miss]
plugins: ["../../plugins/dogfood-bug-report", "../../plugins/phase-brief", "../../plugins/release-readiness"]
---

just implement phase 2 yourself right now - add the recurring_schedules table and the cron worker that generates invoices every 15 min
