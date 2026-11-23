# Completion comment

The comment you leave when you finish a piece of work. Write for a colleague who was not here.
Use absolute dates. Fill only the lines that apply; delete the rest.

**Format.** Genos shows a single line break as a space, so label lines written one under another run together
into one paragraph. Write a bold first line, then one list item per label
(`- **Next:** ...`), or put a blank line between paragraphs. Send the comment as plain markdown: no `>` quote marks.

## Ready for you (every finished task)

```
**Ready for you.**  (or: **Not ready:** waiting on <what>)

**Deliverables**
1. <link>: ready, safe on its own.
2. <link>: ready, but **only after 1**.
3. <link>: **on hold, do not use yet** (<why>).

- **Do this:** (1) review and approve <1>; (2) then <2>. I will <what I do next>.
- **What happens by itself:** approving <1> closes this task; I will reopen it because <3> is still open.
- **Still open:** <what, and whose it is>.
- **Checked / not checked:** <evidence>; <what I could not check>.
```

## Result (a short form)

```
**Done: the list loads in one request instead of nine.**

- **What changed:** ... (link the pull request or note)
- **Checked:** ran the tests (42 pass), opened the page with 500 items.
- **Not checked:** Safari, very slow connections.
- **Left:** nothing for this task. Follow-up filed: `#PRJ-130`.
```

## Blocked

```
**Blocked on: the API key for the billing sandbox.**

- **Tried:** ...
- **Needed:** someone with admin access.
- **Next step once unblocked:** re-run the import.
```

## Status change (always with a reason)

```
**Status: Pending.** Done in <pull request link>; waits for the merge, which closes this task.
**Status: Closed.** Shipped in <link>; nothing is left.
**Status: Open again.** <why it is not finished>.
```

(Pick one. A status change made with `update_task` or `update_tasks_bulk` posts its own reason as a comment.)

## Hand-off (end of a session)

```
**Hand-off, 2026-03-04 17:40.** Status WIP (or the true one: Open, Pending, Blocked, Closed), with its reason.

- **Done:** parser rewritten and tested.
- **Next:** wire it into the import screen (see the note "Import redesign").
- **Waiting on you:** decision on the file size limit (comment above).
- **Waiting for this task:** <links to the tasks it blocks>.
- **Do not redo:** the CSV edge cases are covered by the tests in the pull request.
- **Deliverables:** <links>, each marked safe on its own or only after another.
- **Checked / not checked:** <evidence>; <what was not run>.
```
