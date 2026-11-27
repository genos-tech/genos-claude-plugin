# The dashboard data

## The answer

One JSON object and nothing else: no words before or after it. The server draws the page from it. When the run also gives its own "DASHBOARD PAGE" instruction, that instruction is the exact rule and wins over this summary.

- "title" and "subtitle" (the period or scope): strings.
- "stats": the headline numbers, at most 8 of {"label", "value"}, both strings; 4 is best.
- "blocks": at most 7, in the order to show them, the most important first. Each is {"type", "heading", ...}.
- "narrative" (optional): one or two sentences about what the blocks cannot show.
- "note" (optional): what the page leaves out.

Block types. The number is how many rows or points one block takes.

- "hero", one progress ring: "done", "total", optional "due".
- "status": "counts" with any of Open, WIP, Blocked, Pending, Closed.
- "bars": "rows" of {"text", "value"}, at most 12.
- "trend": "points" of {"label", "closed", "created"}, at most 26, oldest first. "closed" is the column and "created" the line; "legend" names the two when they are something else.
- "meters": "rows" of {"text", "done", "total", optional "due"}, at most 8.
- "workload": "rows" of {"name", "Open", "WIP", "Blocked", "Pending"}, at most 6 people.
- "timeline": "rows" of {"text", "due", optional "status"}, at most 8.
- "attention": at most 3 "groups" of {"title", "tone", "rows"}; "tone" is "overdue", "blocked" or "unowned"; each row is {"text", optional "note"}. Give every row you read, at most 15 per group: the page shows 3 and counts the rest. If a group has more than you give, say so in the page's own "note", not a row's.
- "table": "columns" (at most 4) and "rows" (at most 12 lists of cells).
- "list": "rows", at most 8, only when no other block fits.
- "text": "text", at most two sentences.

Rules.

- Dates are YYYY-MM-DD. Counts are whole numbers. Write headings and labels in the person's language.
- Plain text only. Never write a URL, a path, a link or any markup: the server drops them.
- A row about one thing you read may carry "ref": {"kind": "task", "milestone", "project" or "note", "id": number}. Copy the numeric id from a tool result, never the display id: for a task its task_id, for a milestone its milestone_id (not the task_id on the same row), for a project its project_id, for a note its note_id. A note also needs "note_type". The server makes the link.
- Never invent a number or a name. Leave out a block you have no data for.

Example. Its numbers and ids are made up: yours come from this run.

```json
{
  "title": "My tasks",
  "subtitle": "Last 8 weeks",
  "stats": [
    {"label": "Open", "value": "12"},
    {"label": "Overdue", "value": "2"},
    {"label": "Due in 14 days", "value": "4"},
    {"label": "Closed in 8 weeks", "value": "9"}
  ],
  "blocks": [
    {"type": "status", "heading": "By status", "counts": {"Open": 7, "WIP": 3, "Blocked": 1, "Pending": 1, "Closed": 40}},
    {"type": "trend", "heading": "Closed and added each week", "points": [{"label": "2026-11-09", "closed": 3, "created": 5}, {"label": "2026-11-16", "closed": 6, "created": 2}]},
    {"type": "attention", "heading": "Needs me", "groups": [{"title": "Overdue", "tone": "overdue", "rows": [{"text": "Send the quote", "note": "due 2026-11-20", "ref": {"kind": "task", "id": 101}}]}]},
    {"type": "timeline", "heading": "Due next", "rows": [{"text": "Draft the plan", "due": "2026-12-02", "status": "WIP", "ref": {"kind": "task", "id": 102}}]}
  ],
  "note": "Counts only the tasks assigned to me."
}
```
