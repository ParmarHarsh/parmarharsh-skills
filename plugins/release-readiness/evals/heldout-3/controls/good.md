# Readiness: pebble-notes → production

| Gate | Status | Evidence | Blocking |
|---|---|---|---|
| Tests | UNKNOWN | no shell in this session, so `npm test` did not run | yes |
| Env vars documented | FAIL | `MAIL_API_KEY` is read in `src/mailer.js:1` but missing from `.env.example` | yes |
| No insecure secret fallbacks | FAIL | `SESSION_SECRET` falls back to "pebble-dev-secret" (`src/session.js:3`) | yes |
| Migrations safe | FAIL | `003_drop_legacy_body.sql` drops a column with no down path | yes |
| Backup and tested restore | UNKNOWN | no backup or restore drill found | yes |
| Health and readiness checks | FAIL | no health endpoint | no |
| Rollback path | FAIL | migration 003 cannot be rolled back | yes |

VERDICT: NO-GO

## Blockers

1. Document `MAIL_API_KEY`. 2. Remove the secret fallback. 3. Make 003 reversible or take a backup first.
