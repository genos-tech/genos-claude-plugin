# Templates

Short on purpose. Fill only the lines that apply; delete the rest. Write for a colleague who
was not here. Use absolute dates. Replace the examples with your own words.

## Comments (the work log)

### Starting
> **Starting.** Reading `#PRJ-123` and the linked note. Plan: (1) reproduce, (2) fix,
> (3) add a test. I will not touch the export code.

### Decision (the comment that points to the decision note)
> **Decision: keep the old endpoint, add a new one.** Saved as a note: `Decision: keep the old
> endpoint` (link).
> Why: three clients still call the old one. Option rejected: changing it in place (breaks
> them). Reversible: yes. Needs your OK: no.

### Result (the most useful kind)
> **Done: the list loads in one request instead of nine.**
> - What changed: ... (link the PR or note)
> - Checked: ran the tests (42 pass), opened the page with 500 items.
> - Not checked: Safari, very slow connections.
> - Left: nothing for this task. Follow-up filed: `#PRJ-130`.

### Blocked
> **Blocked on: the API key for the billing sandbox.**
> Tried: ... Needed: someone with admin access. Next step once unblocked: re-run the import.

### Question for the user
> `@name` **Question:** should overdue tasks under a closed milestone still be listed?
> My recommendation: no, they read as done. Say "yes" or "no" and I will apply it everywhere.

### Ready for you (the completion comment, every finished task)
> **Ready for you.**  (or: **Not ready:** waiting on <what>)
> **Deliverables**
> 1. <link>: ready, safe on its own.
> 2. <link>: ready, but **only after 1**.
> 3. <link>: **on hold, do not use yet** (<why>).
> **Do this:** (1) review and approve <1>; (2) then <2>. I will <what I do next>.
> **What happens by itself:** approving <1> closes this task; I will reopen it because <3> is
> still open.
> **Still open:** <what, and whose it is>.
> **Checked / not checked:** <evidence>; <what I could not check>.

### Hand-off (end of a session)
> **State at 2026-03-04 17:40.** Status WIP.
> - Done: parser rewritten and tested.
> - Next: wire it into the import screen (see note "Import redesign").
> - Waiting on you: decision on file size limit (comment above).
> - Do not redo: the CSV edge cases are covered by the tests in the PR.

## Notes (knowledge worth finding again)

Create with `create_note`, type `task` (with `project_id` and `task_id`) so it sits with the
work. Link it from a comment. Edit it as the facts change; do not start a second note on the
same topic.

### Decision record
One note per decision, titled "Decision: <what was decided>". Create it when it is decided,
link it from the task, tell the user in one line. Keep it short: a decision record that takes
longer to read than the decision is not read.
```
# Decision: <what was decided>
Date: 2026-03-04   Status: decided | proposed | superseded by <link>
Decided by: the user | proposed by the assistant, approved by the user | the assistant (within
the task; reversible: yes/no)
## Decision
What we chose, in one or two sentences.
## Why
The reason that decided it.
## Context
Why this came up, in two or three sentences.
## Options considered
- A: ... (pros / cons)
- B: ... (pros / cons)
## Consequences
What gets easier, what gets harder, what to watch, when to revisit it.
## Links
The task, related notes, the chat or comment where it was said.
```

### Findings (the result of an investigation, analysis, search, measurement or test)
Write one for each such piece of work that is more than a one-line lookup, when the result is
known, even if the answer is "no" or "could not find out". Attach it to the task and link it
from a comment.
```
# Findings: <question>
Date: 2026-03-04. Task: #PRJ-123.
## Answer in one paragraph
Say under which conditions it holds.
## Evidence
What I looked at, with links. What I measured, with numbers and the date. How: environment,
data (name, version or date range), method, how I decided what counts as right.
## What I could not find out
What this does not cover: conditions not tested, data not seen, things assumed.
## Next step
## Links
```

### Runbook (how to do or check something)
```
# How to <do X>
When to use it:
Steps: 1. ... 2. ... 3. ...
How to tell it worked:
If it goes wrong:
Last verified: 2026-03-04
```

### Resume note (long work that spans sessions)
```
# Where this work stands
Updated: 2026-03-04
Goal:
Done so far:
In progress:
Next steps (in order):
Open questions / waiting on:
Things already tried that did not work:
Links: tasks, pull requests, notes
```

## Task descriptions

### Feature or chore
```
### 🧾 Summary
One or two sentences: what and for whom.
### 🪜 Motivation
Why now, what it unblocks.
### ✅ Acceptance criteria
- Observable result 1
- Observable result 2
```

### Bug
```
### 🐞 Summary
### 🔁 Steps to reproduce
### 🎯 Expected behavior
### 💥 Actual behavior
```

Keep a task description under about 150 words. Details that will keep growing belong in a
note linked from the task.
