---
name: genos-product-team
description: How to work in Genos as part of a product or software team: engineers, product managers, designers, QA, data scientists and anyone who ships software. Use together with genos-workflow whenever the work involves code, GitHub branches or pull requests, bugs, sprints, releases, specs, or experiments in Genos; when asked to work on a ticket, review or summarize a pull request, plan or report on a sprint or milestone, file or triage a bug, or write up an experiment or decision. It covers how tasks and pull requests stay linked, what to check before closing, how to report test evidence honestly, and when to stop and ask before merging, deploying or touching production.
---

# Genos for product teams

This skill **adds to `genos-workflow`**; read that first. It does not repeat the loop (orient,
plan, do, record, hand off), the "what goes where" table, or the rules on statuses and asking
first. It covers what is specific to people who build software: code, GitHub, bugs, sprints,
releases and experiments.

Find your role below; the first two sections apply to everyone on the team.

## The rule that matters most: a task and its code stay linked

A task is the spec; the branch and pull request (PR) are the delivery. A reader of the task
should be able to see what was built, whether it merged, and what is left, without leaving
Genos.

- **Put the task's display id in the branch name** (`feature/PRJ-42-short-name`). Genos links
  a PR to the task automatically once the repository's webhook is set up, and keeps the
  PR's state (open, draft, merged, closed) up to date on the task.
- A branch that does not name a task, or a branch with no PR yet: `add_task_delivery`.
  Repeating it is harmless. If it warns that the branch or PR title does not name the task,
  check you picked the right task.
- Resuming work on a branch: `find_task_by_delivery` first, to confirm which task it belongs
  to before you write to it. An empty result means "not linked"; never guess from titles.
- **Comment the PR on the task** when you open it: what it does, how it was verified, what
  is not covered, and what to check. See `references/templates.md`.
- Before closing a task, check the PR really merged (`get_pr`), not just that one exists.
  `list_my_tasks` with `delivery: merged_pr` finds tasks whose PR merged but are not closed.
  Details and the tools for reading PRs: `references/github.md`.
- **One logical change per PR.** If you notice something else, file a separate task.

### Statuses with pull requests

| Moment | Task status |
| --- | --- |
| You start work | `WIP` |
| PR open, in review, or changes requested | still `WIP` |
| PR merged and the acceptance criteria are met | `Closed` |
| PR merged but part of the task is still open | back to `WIP`, with a comment saying what is left |
| Waiting on a person, a release or an external team | `Blocked` or `Pending`, with the reason |

A merge usually **closes the task automatically**, even when only part of it shipped. After
any merge, re-read the task. For work that needs several PRs, expect the first merge to close
it: set it back to `WIP` and list the PRs still to come. A parent task or milestone closes
last. That merge-close is also why a follow-up you find does **not** go under the task you are
working on: the task closes with its PR, and its open children then read as closed. File it
under a parent that will stay open (`genos-workflow`, "When to create a task").

## Working a ticket (engineers)

1. **Read the task fully**: description, acceptance criteria, every comment, linked notes, and
   the task's parent. The newest comment may change the scope.
2. **Check the current state of the code before you act.** A bug in the task may already be
   fixed on the main branch; a feature may half exist. Look at the main branch, not only at
   the checkout in front of you.
3. **Work on your own branch**, preferably in a separate worktree or clone, never directly in
   the user's working checkout, which may be in use by them or another session.
4. **Bugs: reproduce first.** Write a test that fails for the reported reason, then fix it. If
   you cannot reproduce it, say so in the task, with what you tried, and do not "fix" a
   guess. A bug report that says "found by a tool, not verified" is a hypothesis: confirm it
   or close it with the reason.
5. **Run the whole test suite before opening a PR**, not only the tests next to your change.
   Shared behaviour is often pinned by tests in modules that look unrelated, and CI runs the
   whole thing against the latest main.
6. **Report evidence, not belief**: tests run and counts, what you checked by hand, and what
   you did not check (a browser, a phone, a slow network, production). If a test failed,
   say which and why. Never write "should work". When the evidence is the result of an
   investigation, a proof of concept or a test run (not just "the PR's tests pass"), it goes in
   a findings note attached to the task (template in `genos-workflow`), not only in a comment
   or the PR description.
7. **Open the PR, do not merge it.** Merging, and anything after it (deploying, running
   migrations, flipping a flag in production), is the user's decision unless they have told
   you otherwise for this task.
8. Leave a result comment on the task (template in `references/templates.md`), set the
   status honestly, and file any follow-ups you found, under a parent that will outlive this
   task, not under it.

### Finish with a "Ready to merge" comment on the task

When **all the PRs of a task are prepared** (code, frontend, docs, config), leave one comment on
the task, in the same shape every time, so the person who merges knows what is safe. Do this for a
task with one PR too. A task with several PRs is where it matters most: someone who sees one of
them may merge it even when it must not go in alone (a docs PR that describes code not yet
merged, a config change that depends on another PR, a stack where the order matters).

The first line says **Ready to merge** or **Not ready to merge**. Then:

- **A table of every PR:** link, repository, merge order, CI state (say what was actually
  checked, and what is still running), and one of: *safe alone*, *only after #N*, *must not be
  merged alone* (why), *hold*.
- **What each merge does to the task:** the first merge usually closes it automatically; say
  whether it is really done then, or that you will reopen it.
- **What the person has to do after merging**, as numbered steps, including anything that is
  not a merge (a production config apply, a flag, a deploy), and which of those you will do
  once they say go.
- **What is not covered**: the check that needs the real environment, the follow-ups filed.

Before that comment exists, a PR that must not be merged yet is opened as a **draft** or says
"do not merge yet, see PRJ-42" at the top of its description. When the set is complete, mark
the drafts ready and post the comment. Template in `references/templates.md`.

### Code review and summaries

To summarize or review a PR for a task: `get_pr` (state, size, description), `list_pr_files`,
`list_pr_commits`, `list_pr_reviews` (verdicts), `list_pr_comments` (line-level feedback).
These read through the GitHub account the user connected in Genos; a repository they cannot
see returns not-found. The pull request tools are not on the core connection: they are on
`.../api/public/v1/mcp/github` and on the full address. If they are missing from your tool list, say
so and give the person the command `claude mcp add --transport http genos-github <API origin>/api/public/v1/mcp/github`
(claude.ai: add it as a second custom connector; it counts as one more connected app). Say what you read and what you did not (the tools return file lists and
sizes, not patches).

## Planning and reporting (product managers, tech leads)

- **A milestone is a goal with an order of work**, not a bucket. Write the goal, the success
  criteria, what is out of scope, the risks, and the order: what to start with, what can run
  in parallel, what blocks what, when each parent closes. `create_task_plan` wires
  dependencies by index in one call; read `get_milestone_summary` and `list_task_dependencies`
  before adding to an existing plan.
- **A good task spec** has a summary, why it matters, and acceptance criteria a stranger can
  check ("an admin can export a CSV of 10,000 rows in under a minute"), not a solution.
  Keep it short; put long designs in a note and link it.
- **Sprints:** `list_sprints` then `get_sprint_summary` for counts by status and priority,
  overdue items, days left and each milestone's progress. A task belongs to its milestone's
  sprint, so move the milestone, not the task.
- **Status reports** are built from the data, not from memory: `get_project_summary`,
  `get_sprint_summary`, `get_stale_tasks` ("what is stuck?"), `get_workload_distribution`
  ("who is overloaded?"), `get_task_blockers`. Lead with what changed and what needs a
  decision, group by project or milestone, name risks plainly. Template in
  `references/templates.md`. Reprioritizing many tasks is a bulk update with a one-sentence
  reason each (`update_tasks_bulk`); say you are doing it, and ask first when it moves
  other people's work.
- **Decisions** go in a note (decision record template in `genos-workflow`), linked from the
  task, with the reason and what was rejected. A decision only in chat is lost by next week.

## Data scientists and researchers on the team

- **One task per question or hypothesis**, with what would change your mind as the acceptance
  criterion. Do not hide a negative result: "did not work, and why" is a result.
- **Record each experiment in a note** attached to the task (template in
  `references/templates.md`): question, data (name, version or date range, how it was
  filtered), method and parameters, the numbers, the conclusion, and how to reproduce.
  Without these an experiment cannot be trusted or repeated.
- **Separate what you measured from what you infer.** Give sample sizes and the metric's
  definition. Do not paste personal or sensitive data into a task, comment or note; refer to
  where it lives.
- Link the experiment to the product task it informs, and say in a comment what decision it
  supports.

## QA, design and others who work alongside engineers

- **QA:** a test plan is a note linked to the task; each bug is its own task with steps to
  reproduce, expected and actual behaviour, the environment, and evidence (a screenshot or a
  log excerpt without secrets). Re-test a fix and say what you tried, including the cases that
  were not affected.
- **Design:** link the design (a file or a note) from the task; put decisions and open
  questions in comments; do not close a UI task until someone has looked at it on the
  devices that matter, and say which you checked.

## Releases

- Treat a release as a milestone with a closing checklist: what ships, what is deliberately
  left out, migrations or flags to flip, who verifies. Write release notes as a note from
  what actually merged (`list_tasks` filtered by milestone and status), not from memory.
- Deploying and production changes are the user's call. Prepare the steps and the checks; ask
  before running them.

## Ask before you do these

On top of the list in `genos-workflow`:

- merging a PR, force-pushing, rewriting history, deleting a branch you did not create;
- deploying, running a migration, changing production data or configuration, flipping a
  feature flag for real users;
- anything that costs money or quota (paid APIs, cloud resources, extra CI runs);
- closing or deleting someone else's task, or moving other people's work in bulk;
- pasting anything that could be a secret (keys, tokens, connection strings, personal data)
  into a task, comment, note or PR description. Never.

## Habits

- File a bug **after** searching for a duplicate and checking the main branch.
- Keep PRs and tasks small and finished; leave the task in a state someone can pick up.
- A claim in a comment is something you checked. "I read the diff" and "I ran it" are
  different; say which.
- When an automated reviewer or agent finds something, verify it before you relay it.
