---
max_turns: 6
timeout_seconds: 300
allowed_tools: [Read, Glob, Grep, Skill]
tags: [collision, near-miss]
plugins: ["../../plugins/deepen-prompt", "../../plugins/phase-brief", "../../plugins/release-readiness"]
---

tighten this prompt, its rambly and way too long. keep the meaning:

hey so i need you to basically go through the customer feedback we got from the survey last month, theres a lot of it, and kind of pull out the main things people are saying, like the big themes, and also if theres anything urgent flag it, and make it short-ish because my manager doesnt read long stuff, maybe bullets? thanks
