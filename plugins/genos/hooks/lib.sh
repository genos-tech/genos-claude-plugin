#!/usr/bin/env bash
# Shared helpers for the Genos plugin hooks. Sourced by the hook scripts, never run on its own.
# Portable on purpose: macOS bash 3.2 and Linux, no jq, no network, no secrets, no associative arrays.
#
# Every hook is a SUGGESTION. A hook here never blocks a tool call, never asks a question and never
# fails the session: each script ends with `exit 0` whatever happens.

# Turn every Genos hook off: GENOS_HOOKS=off (set it in your shell or in the "env" block of
# ~/.claude/settings.json). Anything else leaves them on.
genos_hooks_off() {
    case "${GENOS_HOOKS:-on}" in
        off | OFF | Off | 0 | false | no) return 0 ;;
    esac
    return 1
}

# Read the hook's JSON input (stdin) once, into HOOK_INPUT. Cap it: a tool result can be large.
genos_read_input() {
    HOOK_INPUT=$(head -c 200000 2>/dev/null || true)
}

# genos_json_string <key>: the first string value of "key" in HOOK_INPUT (no unescaping; ids and paths only).
genos_json_string() {
    printf '%s' "$HOOK_INPUT" | sed -n 's/.*"'"$1"'"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n 1
}

# genos_emit_context <event> <text>: print the JSON that adds <text> to Claude's context.
# <text> must contain no double quote, backslash or raw newline: write \n for a line break.
genos_emit_context() {
    printf '{"hookSpecificOutput":{"hookEventName":"%s","additionalContext":"%s"}}\n' "$1" "$2"
}

# A per-session marker file name, so a reminder is not repeated. Empty when there is no session id.
genos_marker() {
    local sid
    sid=$(genos_json_string session_id | tr -c 'A-Za-z0-9_-' '_')
    [ -n "$sid" ] || return 0
    printf '%s/genos-claude-hooks-%s.%s' "${TMPDIR:-/tmp}" "$sid" "$1"
}
