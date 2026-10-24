---
max_turns: 20
timeout_seconds: 600
allowed_tools: [Read, Glob, Grep, Skill]
tags: [trigger, held-out]
---

draft the execution prompt for the next phase - phase 4 is the notifications inbox. bell icon in header, GET /api/notifications?unread=true, mark read via PATCH, max 50 per page, websocket push on new ones. i'll paste it into a fresh session so spell out scope, files likely involved, done criteria and what's out of scope
