---
name: new-library-skill
description: Adds, changes or removes a skill in the parmarharsh-skills library (this repository) the way its CI requires - plugin from templates/skill, spec-only SKILL.md, trigger and near-miss eval cases with grader controls, regenerated collision suite, version and CHANGELOG. Use when the user, working in this repository, says "add a skill that does X", or asks to change or remove one. Not for using a skill in another project.
license: MIT
metadata:
  version: "1.0.0"
---

# New library skill

Follow [docs/adding-a-skill.md](../../../docs/adding-a-skill.md). It is the bar CI enforces. Ask the user before:

- each model-backed run, with its estimate (about 5 cents per eval case on `claude-sonnet-5-5`; a five-case skill measured 18 cents);
- each commit (show the diff), push, or pull request;
- anything that adds `allowed-tools`, hooks, scripts (including a `fixture.sh`) or `!` shell injection.

## 1. Pin down the job

- Restate the skill in one line: what it produces, and what a good result looks like.
- Read every existing description in `plugins/*/skills/*/SKILL.md`. If the new skill overlaps one, say so and propose a merge or a sharper boundary before writing anything.
- Pick a lowercase kebab-case name that says what the skill does.

## 2. Create it from the template

```bash
cp -R templates/skill plugins/<name> && rm plugins/<name>/README.md
mv plugins/<name>/skills/NAME plugins/<name>/skills/<name>
```

Replace every `NAME` and capitalized placeholder.

- **Description:** what it does, then when to use it in the words a user would type, then what it is not for. Keep it under about 500 characters.
- **Body:** concrete steps with evidence to collect. Keep it under about 150 lines; long templates go in `references/`.
- **Specifics:** invent every one. Nothing from real projects, clients, hosts or people.
- **Listing:** add a `plugins` entry to `.claude-plugin/marketplace.json` (`name`, `source: ./plugins/<name>`, a one-line `description`) and a row to the skills table in `README.md`, both in name order.

## 3. Write the eval cases

Rename each case folder after what it tests.

- **3 or more trigger prompts:** lowercase, terse, the way the user types, never naming the skill.
  - Consumer-smoke fires the alphabetically first trigger case on `claude-opus-5-5` after every promote. Name the most typical prompt so it sorts first.
- **2 or more near misses** (`nomatch-*`): the same topic or vocabulary, but a different job. One should be the nearest existing library skill's territory, if any.
- **Output graders:** regexes for the elements only a skill-following answer contains. These are what the skill adds over plain Claude. Don't grade things plain Claude already gets right; they can't show a gain.
- **Controls:**
  - `controls/good.md` is an ideal short answer that every regex grader matches.
  - `controls/bad.md` is a plausible lazy answer that every regex grader rejects.
  - Watch for accidental matches, such as `no PR` matching inside "no problems". Use `\b`.
- **Project fixtures:** if a case needs a project to inspect, copy a folder from `fixtures/` as `project/` with the existing `fixture.sh` and `case.yaml` pattern (`plugins/release-readiness/evals/go-no-go-prod/`). Ask first: `fixture.sh` is a script.

## 4. Check locally (free)

```bash
bin/gen-collision
bin/precheck
```

`bin/precheck` runs validate's free steps. Fix everything it reports. If it says `.notes/denylist.txt` is missing, tell the user; it's private and lives only in the user's main checkout.

## 5. Optional quick eval (ask first)

```bash
claude plugin eval plugins/<name> --scaffold --model claude-sonnet-5-5 --runs 1 --ablation none --max-cost-usd 1 --trust-plugin --no-publish
```

If the skill doesn't fire on a trigger prompt, tune the description, not the prompt. If plain Claude would pass every output grader anyway, the skill adds nothing. Say so, and propose dropping it.

## 6. Hand off

- Show the diff.
- After approval, commit on a branch, push, and open a pull request. CI runs validate and the evals.
- After merge, the user promotes from Actions (docs/adding-a-skill.md, step 5) and syncs projects with `bin/skills-sync`.

## Changing or removing

- **Change:**
  - Edit, then bump `version` in `plugin.json` and `metadata.version` in `SKILL.md` (patch, minor or major).
  - Add the CHANGELOG entry.
  - Update cases and controls if behavior changed, then repeat steps 4–6.
- **Remove:**
  - Delete `plugins/<name>/`, its `.claude-plugin/marketplace.json` entry and its `README.md` row, run `bin/gen-collision` and `bin/precheck`, and open a pull request.
  - Remind the user to run `skills-sync remove <name>` in each project. `.notes/consumers.md` lists them.
  - The `<name>--v<version>` release tags stay. docs/runbook.md says how to delete one.
