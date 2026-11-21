---
name: genos-setup
description: First-run setup of a Genos workspace, after the person has created their account and team. Use together with genos-workflow only when someone is setting Genos up for the first time: "set up Genos", "get started with Genos", "create my first project", "I just signed up, what now", or a workspace with no projects yet. Not for day-to-day work. It covers checking the connection, asking what the work is before building anything, creating the first project, milestone and tasks, what to leave to the person in the app (group chats, accounts), the first records and the decision-note habit, and how to hand back.
---

# Setting up Genos for the first time

This skill **adds to `genos-workflow`**; read that first. It covers only the first run: from
"my account and team exist" to a small workspace that is already in use. The person creates
the account and the team in the Genos app; you cannot. After this, `genos-workflow` is the
skill for everything else.

You teach by doing: the first project the person sees should already be a good example of
how the work will be kept. Tool descriptions in your client are the authority on parameters;
this page is about judgment. A checklist and a sample conversation are in
`references/first-run.md`.

## 1. Check you are connected, and who you are acting for

Call `get_current_user`, `get_team_members` and `list_projects`. Say in one line who you are
acting for and what already exists ("You are Ana, team X, 3 members, no projects yet").

If the Genos tools are missing, do not guess; tell the person how to connect. The address to
paste is shown in Genos under Settings > Developer > Connect an AI app.

- **Claude (claude.ai, Desktop):** add Genos as a custom connector with that address, then
  approve access on the Genos consent page.
- **Claude Code:** run the `claude mcp add --transport http genos <address>` command that the same
  page shows, then `/mcp` and sign in to Genos, then approve on the consent page. Do not use an
  API key for this: the connector signs in with the person's own Genos account.
- **ChatGPT:** support is coming; do not say it works.

The connector needs Core or higher. A new account gets its first month of Core free once its email
address is verified, so the connector normally works from the first day. If a call is still refused
with a message about the plan (the free month has ended, or the address is not verified yet), say so
plainly, point to Settings > Plan & Usage, and stop there. You may say that new accounts get their
first month of Core free; do not promise it to an account that already had it.

An API key (Settings > Developer > API keys) is for scripts, not for the connector. It is sent as an
`ApiKey` header, and the server address must name the team.

## 2. Ask before you build

Ask **one question at a time, your recommendation first**, so it can be answered in a word.
You need three things: what the work is (a project, a team, a study, a launch), who else is
involved, and how the person wants to see progress (a list of tasks, a weekly summary, a
milestone date). Never ask what you can infer from the team, the existing projects or what the
person already said. Stop asking once you can build a first version; it is easy to change.

## 3. Create the first project, then the plan

1. **Search first** (`list_projects`, `search_workspace`) for the same work already there. Reuse
   it instead of creating a second one.
2. `manage_project` for the project. It is visible to the team unless made private: make it private
   only if the person says so or the work is clearly personal (a study), and say which you
   chose. Add tags (`add_project_tag`) or labels (`manage_project_labels`) **only if asked**; an
   empty, plain project is fine.
3. One first milestone and **3 to 7 real tasks** in a single `create_task_plan` call, with
   dependencies by index and an "order of work" in the milestone body. Tasks must be the work
   the person described, each with a short real description, not placeholders and not a
   template filled with guesses. Fewer, true tasks beat a long list of maybes. Pass
   `default_assignee_id` with the person's own user id (from `get_current_user`) unless they
   said otherwise. Tasks left unassigned do not show under their "my tasks" view: on a fresh team
   that view showed only the milestone row.

### Members and group chats

- **Adding or removing members touches other people: ask first** (`manage_project_members`),
  name who and with which role, and never invent a member: only people `get_team_members`
  returns. A new team usually starts with only the person in it. Then there is nobody to add:
  say so, carry on alone, and say how the team grows (invite people in the app).
- **Group chats are created and edited by the person in the Genos app**, not by you. Tell them
  where (the chat list, new group chat) and what to name it. Do not try. Chat is read-only for
  you today.

## 4. Leave the first records the way the rest of the work will be kept

Do this with `genos-workflow`, in the first task of the plan or in a task called for it:

- **One comment** on the project's first task saying what was set up (the project, the
  milestone, the tasks, anything you left for the person).
- **A short task note** on how the person works with their assistant in Genos: what you
  record where (tasks for the work, comments for what happened, notes for what is worth finding
  again), that the person can read, edit and delete anything, and what you will ask before doing.
- **The decision-note rule, in two sentences:** every decision becomes a note titled
  "Decision: ...", with the reason, so nobody has to remember why. Show it once with a **real
  decision from this conversation** (for example "we track launch tasks in one project"), using
  the decision template in `genos-workflow`, and tell the person in one line that you saved it.

If nothing was actually decided yet, write no decision note; do not make one up to demonstrate.

## 5. Hand back

End with three lines and one question:

1. What now exists (project, milestone, number of tasks, the notes) and where to look in the
   app.
2. What is left for the person (a group chat, inviting someone, a choice you did not make).
3. What you will do from now on: record the work in tasks, comments and notes; the person can
   read, edit and delete anything.

Then the **next step they can answer in a word** ("Start with the first task now? yes/no, I
recommend yes"). Use the "Ready for you" shape from `genos-workflow` if the setup was a task.

## Do not

- Delete anything, or change who has access, without asking.
- Invent members, projects or tasks the person did not describe.
- Import private material from elsewhere (other apps, email, calendar, personal notes)
  without asking, and never into a place the team can read.
- Claim a feature that is not live, or call anything "automatic". Say what you will do.
- Build a large structure on the first day. One project that is used beats five that are not.
