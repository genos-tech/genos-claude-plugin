#!/usr/bin/env bash
# Stop: when the session used Genos tools or made commits, remind (once per new piece of work) to leave
# the completion comment and keep statuses true. A reminder only: it never blocks the stop, and it stays
# silent when stop_hook_active is set (a stop hook already forced a continuation), so it cannot loop.
. "$(dirname "$0")/lib.sh" 2>/dev/null || exit 0
genos_hooks_off && exit 0
genos_read_input

# Another stop hook already kept Claude going: do nothing, never loop.
printf '%s' "$HOOK_INPUT" | grep -Eq '"stop_hook_active"[[:space:]]*:[[:space:]]*true' && exit 0

transcript=$(genos_json_string transcript_path)
[ -n "$transcript" ] && [ -r "$transcript" ] || exit 0

# Work done so far, counted from the transcript's tool calls: commits and PR creations, and Genos calls.
work=$(grep -Ec '"name"[[:space:]]*:[[:space:]]*"Bash".*(git[[:space:]]+(-[cC][[:space:]]+[^[:space:]]+[[:space:]]+)*commit[^-[:alnum:]_]|gh[[:space:]]+pr[[:space:]]+create)' "$transcript" 2>/dev/null || true)
genos=$(grep -Ec '"name"[[:space:]]*:[[:space:]]*"mcp__[^"]*[Gg]enos[^"]*"' "$transcript" 2>/dev/null || true)
work=${work:-0}
genos=${genos:-0}
total=$((work + genos))
[ "$total" -gt 0 ] || exit 0

# Say it once for each new piece of work: remember how much work the last reminder covered.
marker=$(genos_marker stop)
if [ -n "$marker" ]; then
    if [ -f "$marker" ]; then
        seen=$(cat "$marker" 2>/dev/null)
        case "$seen" in '' | *[!0-9]*) seen=0 ;; esac
        [ "$work" -gt "$seen" ] || exit 0
    fi
    printf '%s' "$work" > "$marker" 2>/dev/null || true
fi

printf '%s\n' '{"systemMessage":"Genos: before you finish, leave a completion comment on the task (ready or not, what is done, what is left) and set its status to match the real state."}'
exit 0
