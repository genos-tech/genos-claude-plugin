#!/usr/bin/env bash
# PostToolUse on Bash: after a git commit or a gh pr create, suggest linking the work to its Genos task.
# Suggestion only: one line of context, exits 0 always, and says nothing for any other command.
. "$(dirname "$0")/lib.sh" 2>/dev/null || exit 0
genos_hooks_off && exit 0
genos_read_input

# The command sits in the JSON input as plain text (tool_input.command), so a text match is enough.
# `git commit`, `git -C dir commit`, `gh pr create`; a chained command (cd x && git commit) matches too.
if printf '%s' "$HOOK_INPUT" | grep -Eq 'gh[[:space:]]+pr[[:space:]]+create'; then
    genos_emit_context PostToolUse "Genos: if this PR belongs to a Genos task, link it with add_task_delivery (task id plus the PR url) and put the PR link in the task comment. Skip this if no Genos tools are available."
elif printf '%s' "$HOOK_INPUT" | grep -Eq 'git[[:space:]]+(-[cC][[:space:]]+[^[:space:]]+[[:space:]]+)*commit([^-[:alnum:]_]|$)'; then
    genos_emit_context PostToolUse "Genos: if this commit belongs to a Genos task, mention its id (for example MIP-123) in the branch or PR title so the task links itself, or use add_task_delivery. Skip this if no Genos tools are available."
fi
exit 0
