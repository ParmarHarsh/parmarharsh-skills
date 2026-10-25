---
name: dogfood-bug-report
description: Turns a rough bug description into a reproducible bug report with numbered steps, expected versus actual behavior, the environment and one line on the suspected area, listing every unknown as a question for the reporter. Use when the user asks to write up, clean up or file a bug report or issue from rough notes. Not for debugging or fixing the bug, or for prioritizing a backlog.
license: MIT
metadata:
  version: "1.0.0"
---

# Bug report

Turn what the reporter said into an issue another developer can reproduce without asking anything. Never invent a detail the reporter didn't give: every unknown becomes a numbered question.

## 1. Collect what is known

From the description, and any log, error text or file the user points to, note:

- the action taken and the data involved (item counts, exact text typed, file names);
- what happened, quoting any error message exactly;
- what should have happened;
- where: app version, platform and device, browser or client, account or plan;
- when it started and how often it happens.

If the user names files in the current project, read them before naming a suspected area. Don't run or change anything.

## 2. Write the steps to reproduce

- Number them. One action per step.
- Start from a known state, such as "Signed in as a Pro user, on the Invoices page".
- Use the reporter's concrete values.
- End a guessed step with `(assumed, Q<n>)`.
- The last step is the one that shows the bug.

## 3. Expected versus actual

- **Expected:** one sentence.
- **Actual:** one sentence, with the exact error text if there is one.
- **Frequency:** always, intermittent (with the reporter's numbers), or `Unknown (Q<n>)`.

## 4. Environment

List app version, platform, browser or client, account or plan, and first seen. A field the reporter didn't give reads `Unknown (Q<n>)`.

## 5. Suspected area

One line starting `Suspected area:`, naming the feature or module most likely involved and the clue that points there. It is a hypothesis; say so. If nothing points anywhere, write `Suspected area: unclear (Q<n>)`.

## 6. Questions for the reporter

Number them Q1, Q2 and so on, matching every `Q<n>` used above. Ask only what blocks reproduction or narrows the cause, at most five, each answerable in one line.

## Output

Reply with the report only, ready to paste into a tracker. Don't file it anywhere.

```markdown
## <What breaks, where, under which condition>

**Steps to reproduce**
1. …

**Expected:** …
**Actual:** …
**Frequency:** …

**Environment**
- App version: …
- Platform: …
- Browser or client: …
- Account or plan: …
- First seen: …

**Suspected area:** …

### Questions for the reporter
- Q1. …
```
