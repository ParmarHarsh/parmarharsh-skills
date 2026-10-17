# parmarharsh-skills

My Claude Code skills, kept in one place and tested before any project uses them.

| Skill | What it does |
|---|---|
| [phase-brief](plugins/phase-brief/skills/phase-brief/SKILL.md) | Writes the brief that another session executes for one phase of work, and grades the result against it. |
| [release-readiness](plugins/release-readiness/skills/release-readiness/SKILL.md) | Runs a go/no-go check before a build ships to an environment. |

Every skill uses only the [Agent Skills](https://agentskills.io/specification) frontmatter fields, so the same folder also works as a claude.ai upload.

## Use a skill in a project

Projects get plain copies under `.claude/skills/`. Claude Code loads these in the terminal, the desktop app, and Claude Code on the web without any setup, which no plugin or submodule route does.

```bash
# from inside the project; bin/ is in a local clone of this repo
~/path/to/parmarharsh-skills/bin/skills-sync sync phase-brief release-readiness
git add .claude && git commit -m "skills: sync stable"
```

`sync` copies each skill from the `stable` branch and records it in `.claude/skills.lock`:

```
<skill> <git tree hash> <library commit> <ref> <library url>
```

Day-to-day commands:

| Task | Command |
|---|---|
| Upgrade every skill in the lock | `skills-sync sync`, review the diff, commit |
| Roll back | `git revert` the sync commit |
| Hold one skill at an older release | `skills-sync sync --ref <skill>--v<version> <skill>` |
| Stop using a skill | `skills-sync remove <skill>` |
| Detect hand edits | `skills-sync check` exits 1 if any copy differs from the lock |

`sync` refuses to overwrite a hand-edited copy unless you pass `--force`. Change skills here, not in the copies.

## Layout

```
.claude-plugin/marketplace.json   one entry per skill plugin
plugins/<skill>/
  .claude-plugin/plugin.json      version is bumped on every release
  skills/<skill>/SKILL.md         the skill, plus references/
  evals/                          claude plugin eval suite for this skill alone
  CHANGELOG.md
evals/                            collision suite: every prompt, with all skills loaded
fixtures/notes-app/               a small invented app; eval cases hold exact copies
bin/skills-sync                   vendoring and drift check
```

## Test

```bash
claude plugin eval plugins/<skill> --scaffold --trust-plugin --no-publish   # one skill, with a no-plugin baseline
claude plugin eval . --case '*--*' --ablation none --runs 1 --trust-plugin --no-publish   # collisions
```

Each suite has three prompts that should trigger the skill, written the way I'd type them, and two near misses that must not trigger it. Output graders are deterministic regexes over the reply. A skill that doesn't beat the no-plugin baseline doesn't ship.

Cases that inspect a project carry a copy of `fixtures/notes-app` and a `fixture.sh`. That script copies the app into the run's empty workspace and commits it, so the prompt can say "this repo". It runs only with `--scaffold`.

## Release

1. Change a skill on a branch, bump `version` in its `plugin.json`, and add a `CHANGELOG.md` entry. A plugin with an unchanged `version` hides new commits from marketplace installs.
2. Open a pull request. The **validate** workflow checks manifests, frontmatter, fixtures and collision coverage, and summarizes any change to `allowed-tools`, hooks, scripts or `!` injection. The **evals** workflow runs the changed skills' suites and the collision suite.
3. Merge, then run the **evals** workflow manually on `main` with `promote` checked. It re-runs the evals for skills changed since `stable`. If they pass, it fast-forwards `stable` and tags each changed skill `<skill>--v<version>`.
