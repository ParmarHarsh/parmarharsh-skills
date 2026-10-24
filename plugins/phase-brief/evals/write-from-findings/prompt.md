---
max_turns: 20
timeout_seconds: 600
allowed_tools: [Read, Glob, Grep, Skill]
tags: [trigger]
---

turn findings D-2 and D-4 from yesterday's audit into instructions for a fresh session to fix, it won't see this chat.
D-2: the invoice export endpoint returns other tenants' rows when ?tenant= is omitted.
D-4: password reset tokens never expire.
everything else from the audit waits for later
