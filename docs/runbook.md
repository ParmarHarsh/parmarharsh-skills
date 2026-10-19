# Runbook

Everything that ever needs doing, in one page. Day to day there is only one job: **add a skill** ([adding-a-skill.md](adding-a-skill.md)).

## Release a skill change

1. Open a pull request.
2. CI runs **validate**, which is free, and **evals**, about $1.50 to $2 of plan usage.
3. Merge.
4. Go to Actions → **evals** → Run workflow on `main`, with **promote** checked.

Promote:
- re-runs evals for everything changed since `stable`;
- fast-forwards `stable`;
- tags `<skill>--v<version>` for each new version;
- runs **consumer-smoke**.

`main` accepts only pull requests that pass validate. `stable` and the release tags move only through promote. Rulesets enforce both.

## Update a project that uses skills

```bash
~/path/to/parmarharsh-skills/bin/skills-sync status   # what is behind stable
~/path/to/parmarharsh-skills/bin/skills-sync sync     # take stable for every locked skill
git diff && git add .claude && git commit -m "skills: sync stable"
```

`.notes/consumers.md` (private) lists which repos use which skills.

## Roll back

| Scope | How |
|---|---|
| One project | `git revert` the sync commit, or hold one skill at an older release: `skills-sync sync --ref <skill>--v<old version> <skill>` |
| Everyone | Revert the change on `main` in a pull request, bump the version (for example 2.0.1), and promote. `stable` only moves forward |

## Add a project

```bash
skills-sync sync <skill>...
git add .claude && git commit
```

Add the repo to `.notes/consumers.md`.

The copies load in the terminal, the desktop app and Claude Code on the web without any setup. To catch hand edits in that repo's CI, add a step that runs `skills-sync check`.

## Rotate the CI token (yearly; validate warns 30 days ahead)

1. In the macOS Terminal app, **not** in a Claude chat, run `claude setup-token`.
2. Paste the token on github.com → this repo → Settings → Secrets and variables → Actions → `CLAUDE_CODE_OAUTH_TOKEN` → Update.
3. Put the new expiry date (a year from today) in `.github/ci-token-expires` and merge that in a pull request.
4. Remove the old token: claude.ai → Settings → Claude Code → trash icon.

## Upgrade Claude Code in CI

1. Go to Actions → **evals** → Run workflow, with **skills** set to `all` and **claude_code_version** set to the new version. This tests the candidate without changing anything, for about $3.50.
2. If it's green, change `.github/claude-code-version` in a pull request.
3. If a skill regresses on the new version, fix the skill first.

## Monthly

Dependabot opens one pull request a month bumping the pinned actions. Merge it once validate is green.

## What CI checks

| Workflow | Checks | Cost |
|---|---|---|
| **validate** (every push and pull request) | Manifests, spec frontmatter, the rules in `bin/check-skills`, the `skills-sync` behavior test, token expiry, and a summary of changes to `allowed-tools`, hooks, scripts and `!` injection | Free |
| **evals** (skill pull requests, or by hand) | Each changed skill against its no-plugin baseline: score ≥ 0.8 per case, mean Δ ≥ 0.3 on trigger cases; collision suite | Uses plan usage |
| **consumer-smoke** (after promote, or by hand) | A fresh project vendors every skill from `stable`; each skill is listed and fires on its canonical prompt on `claude-opus-5-5` | Small |

Models: evals score on `claude-sonnet-5-5`; smoke checks triggering on `claude-opus-5-5`. In measurement over 5 runs, both models passed every case of both skills with similar margins over plain Claude, and Sonnet uses about half the usage.
