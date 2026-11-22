#!/usr/bin/env bash
# SessionStart: add a short note to Claude's context so Genos is used without anyone calling a skill.
# It only injects instructions. A hook cannot use the Genos sign-in, so it reads no Genos data.
# Suggestion only: exits 0 always.
. "$(dirname "$0")/lib.sh" 2>/dev/null || exit 0
genos_hooks_off && exit 0
genos_read_input

# Once /genos:setup has written the rules block to a memory file, Claude already has these rules: say nothing.
genos_rules_installed && exit 0

# Whether the Genos connector is signed in cannot be checked from a hook, so the text is conditional:
# Claude sees its own tool list and stays silent when no Genos tools are there.
genos_emit_context SessionStart "Note from the Genos plugin the user installed: when Genos tools are available in this session (tool names contain Genos), the user wants them used without having to ask; when they are not available, Genos can be ignored.\nThe user starts work from get_my_briefing (or get_task for a task they name), and keeps tasks, decisions (a note titled Decision: ...), progress and a completion comment in Genos, with what is created organized under a parent and blockers.\nThis is a preference, not a rule: it never blocks the user or the work.\nThe Genos rules are not in the user memory yet: suggest once that they run /genos:setup."
exit 0
