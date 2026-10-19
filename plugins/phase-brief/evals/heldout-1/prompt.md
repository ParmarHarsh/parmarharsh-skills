---
max_turns: 20
timeout_seconds: 600
allowed_tools: [Read, Glob, Grep, Skill]
tags: [trigger, held-out]
---

write the instructions for a separate agent session to do phase 2 of my invoicing app: add recurring invoices. new table recurring_schedules (id, invoice_template_id, cadence enum weekly/monthly/quarterly, next_run_at), a cron worker that runs every 15 min and generates invoices, and POST /api/recurring + DELETE /api/recurring/:id. dont touch the pdf renderer. needs tests for the cadence math
