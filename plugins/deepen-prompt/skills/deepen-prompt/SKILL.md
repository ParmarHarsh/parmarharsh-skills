---
name: deepen-prompt
description: Rewrites a task prompt to ask for what a top professional in the field would do - the step they'd add, the raw material they'd start from instead of digested summaries, their methods and tools, and an outside check that shows the result is right. Same deliverable, deeper work. Use when the user asks for a deeper (not bigger) version of a task or prompt, or how an expert would approach it before rewriting. Not for shortening or proofreading a prompt, or doing the task itself.
license: MIT
metadata:
  version: "1.0.0"
---

# Deepen a prompt

Turn the user's prompt into one that asks for the work a top professional in the field would do. Deeper, not bigger: the deliverable stays the same, while the inputs, method and checks change. Every answer is specific to this field and this task (a named dataset, document, instrument, standard, technique or tool). Generic advice such as "do thorough research" or "consult an expert" doesn't count.

## 1. Read the task

- **The prompt.** Use the text the user pasted or the task they described. If they say "this" and paste nothing, use their last request in the conversation. Ask for the prompt in one line only if there is none.
- **The field.** Name the role that does this work at the top level: a survey methodologist, a forensic accountant, a staff site reliability engineer, an investigative reporter. If two fields could own it, pick the one whose standard of proof fits the deliverable, and say so.
- **The deliverable.** Write one line: what the prompt produces, for whom, and at what size. It stays fixed through the rewrite.
- **What's digested.** List what the prompt leans on that someone has already processed: summaries, dashboards, averages, secondhand coverage, AI output, the user's own paraphrase.
- **Files.** If the prompt points to files or data you can read, open them so the answers are grounded. Don't carry out the task.

If the audience, purpose or constraints are unclear, pick the likeliest reading, state it in one line, and go on. Don't stop to ask.

## 2. Answer the four questions

Give two to four bullets for each, each tied to this task.

1. **What a top professional would do that you're not asking for.** The moves that separate expert work from competent work here, such as:
   - pinning down the question before answering it;
   - segmenting before averaging;
   - checking the base rate;
   - reading the cases that disagree;
   - sizing the error.

   Say why each move changes the result. These are steps in the work, not extra deliverables.
2. **Rawest material.** The primary material that the digested inputs were made from: the row-level export, the full text, the original filing or study, the logs, the recordings, the source code, the instrument readings. For each, say what the digested version hides (sampling, averaging, survivors only, someone's framing) and how to get the raw version. If it's out of reach, say so and name the closest primary stand-in.
3. **Methods and tools.** The named techniques and tools practitioners use for this: a specific test, coding scheme, model, standard, checklist, profiler or library. Prefer the field's standard method to a novel one. Generic verbs like "analyze" or "research" don't count.
4. **Outside check.** What, other than Claude or the user, would show the result is right, and what result would show it's wrong. It must be able to fail. These count:
   - a test or measurement;
   - a reconciliation against an independent total;
   - a prediction checked against what happens;
   - a replication, or a source table that every number traces to;
   - review by a practitioner, or by the people affected, against a stated pass condition.

   These don't count: Claude's self-review, the user's sense that it looks right, or "consult an expert" with no pass condition.

## 3. Rewrite the prompt

- **Same deliverable.** Ask for exactly what step 1's line says, with no new sections, outputs, audiences or extras. If the original asked for a one-page memo, the rewrite asks for a one-page memo.
- **Raw inputs.** Replace each digested input with its raw material, or tell the reader to ask for it before starting.
- **Method.** Name the methods and tools to use, in the order they'd be used.
- **Done means checked.** Write the outside check in as the acceptance condition. Say what must hold before the result counts as done, and what to report if it doesn't.
- **Honest limits.** Ask the reader to say what couldn't be checked and how confident each finding is.
- **Lean.**
  - Write it in the user's voice, to whoever will run it.
  - Cut anything from the original that made it bigger without making it better.
  - Keep it under about 200 words, unless the original was longer.

## Output

Use these headings, in this order:

1. **What a top professional would do here**
2. **Rawest material**
3. **Methods and tools**
4. **Outside check**
5. **Rewritten prompt**, in a fenced block so it can be copied as is.

After the prompt, write one line: `Same deliverable: <the line from step 1>`. Then offer, in one line, to run the rewritten prompt, and stop. Don't run it unless the user asks.
