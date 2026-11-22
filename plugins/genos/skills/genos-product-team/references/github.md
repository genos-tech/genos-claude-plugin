# Tasks and GitHub in Genos

How a Genos task and a GitHub branch or pull request (PR) stay linked, and what the
assistant can read. Tool descriptions in your client are the authority on parameters.

## How the link is made

A task records its deliveries (repository, branch, PR URL, state, merge time). `get_task`
returns them as `deliveries`. Links come from two places:

1. **The GitHub webhook**, for a branch whose name contains the task's display id
   (`feature/PRJ-42-x`, `prj-42`). When the PR opens, the task gets a link; every later event
   (closed, merged, reopened, retitled) updates the state of every link to that PR. This only
   works for repositories that have the webhook registered by someone in the team.
2. **`add_task_delivery`**, for any other branch, or a branch with no PR yet. Pass `pr_url`, or
   `branch` plus `repo` (`owner/name`). Adding it also tries to install the repository's
   webhook with the user's GitHub connection; if the result carries `webhook_warning`, tell
   the user. `display_id_warning` means neither the branch nor the PR title names this task:
   check, and undo with `remove_task_delivery` if it is the wrong one.

Writing the same link twice changes nothing: one row per task and PR, and one per task and
branch until a PR exists.

## Going the other way

`find_task_by_delivery` (by `branch` and optionally `repo`, or by `pr_url`) answers "which
task is this for?". It checks recorded links first, then a display id in the branch name, and
nothing else. An empty `matches` means not linked. Use it when you resume work on a branch.

`list_my_tasks` can filter on delivery:

| `delivery` | Tasks |
| --- | --- |
| `open_pr` | A PR is open (drafts count): what is in flight |
| `merged_pr` | A PR merged and the task is not closed: usually one to review and close |
| `no_pr` | No PR recorded |

A link whose state is `unknown` is in neither `open_pr` nor `merged_pr` (that would be a
guess); it still counts as a PR.

## Reading a pull request

These run as the user, through the GitHub account they connected in Genos under Integrations.
A repository the user cannot see returns not-found. They are on the `github` connection
(`.../api/public/v1/mcp/github`) and the full address, not on the core one.

| Tool | Gives you |
| --- | --- |
| `get_pr` | state (open, draft, merged, closed), merge time, branches, diff size, the start of the description |
| `list_pr_files` | files changed with status and line counts (no patch content) |
| `list_pr_commits` | the commits |
| `list_pr_reviews` | formal reviews, newest first: who, verdict (APPROVED, CHANGES_REQUESTED, COMMENTED, DISMISSED), summary |
| `list_pr_comments` | line-level feedback |

Use `get_pr` to confirm a PR merged **before** you close its task. Say in your comment what
you read: you saw sizes and file lists, not the code.

## What to remember

- A merge often closes the task by itself. Re-read it afterwards; if part of the work is left,
  set it back to `WIP` and say what remains.
- A task that needs several PRs: the first merge may close it. Plan for that.
- Pushing a branch, opening a PR and commenting are routine. Merging, deploying and changing
  production are the user's decisions unless they said otherwise.
- Do not put secrets in a branch name, a PR title, a description or a comment.
