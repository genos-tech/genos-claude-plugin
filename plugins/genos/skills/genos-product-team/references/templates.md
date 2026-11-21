# Templates for product teams

Short on purpose; fill the lines that apply. Use absolute dates. For the generic comment and
note templates (starting, decision, result, blocked, hand-off, decision record, runbook), see
`genos-workflow/references/templates.md`.

## PR description

```
## What
One or two sentences. Link the task: PRJ-42.

## Why
The problem this solves, in the user's terms.

## How it was verified
- Tests run: <suite>, <count> passed, <what failed and why, if anything>
- Checked by hand: <what, where>
- Not verified: <browser, device, production, load...>

## What users see
Nothing / <the change>.

## Risks and rollout
Migrations, flags, merge order with other PRs, how to undo.
```

## Task comment when a PR is opened

> **PR up: <link>** (not merged).
> What it does: ...
> Verified: whole suite, 1,204 tests pass; checked the export with 10,000 rows.
> Not verified: Safari; very large files.
> Merge order / notes: merge after PRJ-41's PR. Merging closes this task; I will set it back
> to WIP if anything is left.

## Task comment when all PRs are ready ("Ready to merge")

```
**Ready to merge.**   (or: **Not ready to merge:** <what is missing>)

| PR | Repo | Order | CI | Merge it |
| --- | --- | --- | --- | --- |
| <link> | api | 1 | all required checks passed | safe alone |
| <link> | frontend | 2 | passed; one report-only check red (also red on main) | only after 1 |
| <link> | docs | 3 | passed | **must not be merged alone**: it describes the code in 1 |

**What merging does:** the first merge closes PRJ-42 automatically; it is NOT done yet
(<what is left>), so I will set it back to WIP.
**After merging, you:** 1. say "apply" (the production config change in 1 needs it);
2. look at <where> on <date>. **I then:** run the plan, apply, and check <what>.
**Not covered:** <what needs the real environment>. **Follow-ups filed:** PRJ-57, PRJ-58.
```

A task with a single PR gets the same comment in one line: **Ready to merge:** <link>, safe
alone, checks passed, nothing else needed.

## Task comment after the merge

> **Merged <date>.** Acceptance: met / not met (still open: ...). Status set to Closed /
> WIP. Follow-ups filed: PRJ-57.

## Bug report (new task)

```
### 🐞 Summary
One sentence: what is wrong, for whom.
### 🔁 Steps to reproduce
1. ...
### 🎯 Expected behavior
### 💥 Actual behavior
### Environment and evidence
Version or commit, browser or device, a screenshot or a log excerpt (no secrets).
### Reproduced?
Yes, by me on <date> / not yet / found by a tool and not verified.
```

Before filing: search for a duplicate and check the main branch; it may already be fixed.

## Sprint or weekly status

```
# <Project or sprint>: status, <date>
**Overall:** on track / at risk / blocked: one sentence why.
## Done since last report
- PRJ-12 <outcome> (PR merged)
## In progress
- PRJ-20 <where it stands>, owner, next step
## Needs a decision or help
- <question>, who decides, by when, my recommendation
## Risks
- <risk>: likelihood, impact, what would reduce it
## Next
- <the next two or three things>
```

Build it from `get_sprint_summary`, `get_project_summary`, `get_stale_tasks` and
`get_task_blockers`, not from memory. Lead with decisions and risks.

## Experiment record (a note attached to the task)

```
# Experiment: <question>
Date: 2026-03-04   Owner:   Status: running | done | abandoned
## Question and hypothesis
What we want to know; what result would change our mind.
## Data
Source, version or date range, filters, size, known problems.
## Method
Model or analysis, parameters, metric and its definition, how train/test were split.
## Result
The numbers, with sample sizes. A table beats a paragraph.
## Conclusion
What we believe now, how sure, what we do not know.
## Decision it supports
Link to the task or decision record.
## Reproduce
Exact steps, code reference (branch or commit), environment.
```

## Test plan (a note linked to the task)

```
# Test plan: <feature>
Scope: what is covered, what is not.
Environments and devices:
Cases: | # | Steps | Expected | Result (pass/fail, date) |
Edge cases and negative cases:
Regression areas to re-check:
Exit criteria: what "good enough to ship" means.
```

## Release notes (a note, built from what merged)

```
# Release <name or date>
## New
- <user-visible change> (PRJ-30)
## Improved / fixed
- ...
## Known issues
- ...
## Upgrade notes
Migrations, flags, config changes, who verifies after deploy.
```
