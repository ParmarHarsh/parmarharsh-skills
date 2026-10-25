---
max_turns: 6
timeout_seconds: 300
allowed_tools: [Read, Glob, Grep, Skill]
tags: [collision, trigger]
plugins: ["../../plugins/deepen-prompt", "../../plugins/phase-brief", "../../plugins/release-readiness"]
---

need a handoff doc for another agent to run phase 3 of the migration: move session storage from in-memory to redis. keep the same SessionStore interface, add a REDIS_URL env var, ttl 7 days, fall back to memory if redis is down in dev only. it should stop and ask before changing any auth middleware. write it so it can work cold with no context
