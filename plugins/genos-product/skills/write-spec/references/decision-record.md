# Decision record

One note per decision, titled "Decision: <what was decided>". Create it when the decision is made,
link it from the task, and tell the person in one line. Update an existing record instead of
writing a second; a reversal marks the old one superseded. Keep it short: a record that takes
longer to read than the decision is not read.

```
# Decision: <what was decided>
Date: 2026-03-04   Status: decided | proposed | superseded by <link>
Decided by: the person | proposed by the assistant, approved by the person | the assistant
(within the task; reversible: yes/no)

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

The comment that points to it:

> **Decision: keep the old endpoint, add a new one.** Saved as a note: `Decision: keep the old
> endpoint` (link).
> Why: three clients still call the old one. Option rejected: changing it in place (breaks
> them). Reversible: yes. Needs your OK: no.
