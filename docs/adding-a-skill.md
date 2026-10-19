# Adding a skill

In this repository, ask Claude: **"Add a skill that does X."** The `new-library-skill` skill in `.claude/skills/` follows this page. This page is also the bar CI holds every skill to.

## The acceptance bar

A skill ships only when all of these hold. CI enforces each one (`bin/check-skills` and the evals workflow).

| Rule | Detail |
|---|---|
| One skill per plugin | `plugins/<name>/.claude-plugin/plugin.json` names `<name>` and has a `version`. The skill lives in `plugins/<name>/skills/<name>/SKILL.md`. Names are lowercase kebab-case |
| Spec-only frontmatter | `name`, `description`, `license`, `compatibility`, `metadata`, `allowed-tools`, and nothing else, so the folder also works as a claude.ai upload |
| Small always-on cost | Each session in every consumer carries the skill's listing. `claude plugin details` must report **≤ 200 tokens** always-on. Keep the description under about 500 characters, with the use case first |
| Short body | Keep `SKILL.md` under about 150 lines. Templates and long checklists go in `references/` |
| Nothing private | No names of real clients, projects or people, no hosts, home paths, emails, keys, or text pasted from other repos or transcripts. Invent every specific. CI scans for generic patterns. Run the local denylist check before pushing |
| Approval-gated features | `allowed-tools`, hooks, scripts and `!` shell injection need explicit approval. CI lists any change to them in the run summary |
| At least 3 trigger cases | Natural phrasing, the way the user would type it. Never name the skill. Each has a Skill grader for the skill, plus at least one output grader |
| At least 2 near misses | `evals/nomatch-*`: the same topic or vocabulary, but a different job. Grader: `tool_used`, `tool: Skill`, `min: 0`, `max: 0`, `arm: both` |
| Deterministic graders | Prefer `regex`, `tool_used` and `file_exists`. Use `llm` graders only for short outputs, with explicit PASS and FAIL conditions |
| Grader controls | Each trigger case has `controls/good.md`, which every regex grader must pass, and `controls/bad.md`, which every regex grader must fail. This proves a grader can tell a good answer from a bad one |
| Collision suite | `evals/` is generated: run `bin/gen-collision`. With every skill loaded, a trigger prompt must fire only its own skill, and a near miss none |
| Beats plain Claude | Every case scores **≥ 0.8**, and the mean Δ over the no-plugin baseline on trigger cases is **≥ 0.3** (evals workflow, `claude-sonnet-5-5`). For calibration: the shipped skills measure 0.57 and 0.74 over 5 runs; a held-back audit skill measured 0.12. A skill that doesn't beat the baseline isn't shipped |
| Versioned | A change to what ships (`skills/` or `plugin.json`) bumps `version` and adds a `## <version>` entry to the plugin's `CHANGELOG.md` |

## Steps

1. **Draft.** Ask Claude in this repo to add the skill. It copies `templates/skill/` to `plugins/<name>/`, writes the skill and its cases, and runs:
   ```bash
   bin/gen-collision
   bin/check-skills --denylist .notes/denylist.txt
   ```
2. **Quick eval, optional.** This uses plan usage, about $0.05 per run, so Claude asks first:
   ```bash
   claude plugin eval plugins/<name> --scaffold --runs 1 --ablation none --trust-plugin --no-publish
   ```
3. **Open a pull request** from a branch. `main` only accepts pull requests that pass **validate**. The **evals** workflow runs the changed skill's suite against the baseline, plus the collision suite (about $1.50 to $2).
4. **Merge** once both are green.
5. **Promote.** Go to Actions → evals → Run workflow on `main` with **promote** checked. It re-runs the evals for everything changed since `stable`, fast-forwards `stable`, tags `<name>--v<version>`, then runs **consumer-smoke**. Consumer-smoke vendors every skill into a brand-new repo and checks each one fires.
6. **Use it in a project:**
   ```bash
   ~/path/to/parmarharsh-skills/bin/skills-sync sync <name>
   git add .claude && git commit -m "skills: add <name>"
   ```

## Changing or removing a skill

- **Change:**
  - Edit the skill. Bump the version: patch for wording, minor for new behavior, major for removed behavior. Add the CHANGELOG entry, then follow steps 3–5.
  - Projects pick it up with `skills-sync sync`; `skills-sync status` shows which ones are behind.
- **Remove:**
  - Delete `plugins/<name>/`, run `bin/gen-collision`, open a pull request, and promote.
  - In each project, run `skills-sync remove <name>`. `skills-sync status` reports it as GONE until then.
