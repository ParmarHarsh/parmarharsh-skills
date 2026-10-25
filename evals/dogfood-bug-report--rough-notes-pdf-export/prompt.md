---
max_turns: 6
timeout_seconds: 300
allowed_tools: [Read, Glob, Grep, Skill]
tags: [collision, trigger]
plugins: ["../../plugins/dogfood-bug-report", "../../plugins/phase-brief", "../../plugins/release-readiness"]
---

turn my notes into a proper bug report: tapping export pdf on an invoice with more than 50 line items just spins forever on android. worked fine last week. customer is on the pro plan
