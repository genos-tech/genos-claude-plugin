# Tasks and GitHub in Genos

How a Genos task and a GitHub branch or pull request (PR) stay linked, and what you can read. The tool descriptions in your client are the authority on parameters.

## How the link is made

A task records its deliveries (repository, branch, PR address, state, merge time). `get_task` returns them as `deliveries`. Links come from two places:

1. **The GitHub webhook**, for a branch whose name contains the task's display id (`feature/PRJ-42-x`). When the PR opens the task gets a link, and every later event (closed, merged, reopened, retitled) updates the state of every link to that PR. It works only for repositories where someone on the team registered the webhook.
2. **`add_task_delivery`**, for any other branch, or a branch with no PR yet. Pass `pr_url`, or `branch` plus `repo` (`owner/name`). It also tries to install the repository's webhook with the person's GitHub connection: a `webhook_warning` in the result goes to the person. A `display_id_warning` means neither the branch nor the PR title names this task: check, and undo with `remove_task_delivery` if it is the wrong one.

Writing the same link twice changes nothing: one row per task and PR, and one per task and branch until a PR exists.

## Going the other way

`find_task_by_delivery` (by `branch` and optionally `repo`, or by `pr_url`) answers "which task is this for?". It checks recorded links first, then a display id in the branch name, and nothing else. An empty `matches` means not linked.

`list_my_tasks` filters on `delivery`: `open_pr` (a PR is open, drafts count: what is in flight), `merged_pr` (a PR merged and the task is not closed: usually one to review and close), `no_pr`. A link whose state is `unknown` is in neither of the first two.

## Reading a pull request (the `github` address or the full address, not core)

| Tool | Gives you |
| --- | --- |
| `get_pr` | state (open, draft, merged, closed), merge time, branches, diff size, the start of the description; no checks |
| `list_pr_files` | files changed with status and line counts, no patch content |
| `list_pr_commits` | the commits |
| `list_pr_reviews` | formal reviews, newest first: who, verdict, summary; an empty list means no reviews, never approval |
| `list_pr_comments` | line-level feedback |

These run as the person, through the GitHub account they connected in Genos. A repository they cannot see returns not-found. Say in your comment what you read: sizes and file lists, not the code. Confirm a PR merged with `get_pr` before you close its task.

## What to remember

- A merge often closes the task by itself. Re-read it afterwards; if part of the work is left, set it back to in progress and say what remains.
- A task that needs several PRs: the first merge may close it. Plan for that (the task id only on the last PR).
- Pushing a branch, opening a PR and commenting are routine. Merging, deploying and changing production are the person's decisions unless they said otherwise.
- No secrets in a branch name, a PR title, a description or a comment.
