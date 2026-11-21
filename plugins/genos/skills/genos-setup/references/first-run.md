# First run: checklist and sample conversation

Placeholders only. Replace with the person's own words. Use absolute dates.

## Checklist

Tick each one, or say why it was skipped.

- [ ] Connected: the plan is Core or above (on Free, stopped and pointed to Settings > Plan &
      Usage); `get_current_user`, `get_team_members`, `list_projects` answered; said who I act for
      and what already exists.
- [ ] Asked what the work is, who is involved and how progress should be seen, one question at a
      time, recommendation first; asked nothing that could be inferred.
- [ ] Searched for the same work before creating anything (`list_projects`, `search_workspace`).
- [ ] Project created (private only if asked or clearly personal; said which); tags and labels only if asked.
- [ ] One milestone with an "order of work", and 3 to 7 real tasks with dependencies, all
      assigned to the person (`default_assignee_id`), so they show under "my tasks".
- [ ] Members: asked before adding anyone; only people from `get_team_members`; if the team is
      only the person, said so.
- [ ] Group chats: told the person where to create them in the app; did not try.
- [ ] One comment on the first task: what was set up.
- [ ] One task note: how the person works with their assistant in Genos.
- [ ] Decision rule explained in two sentences; one real decision saved as
      "Decision: ..." (or none, because none was made yet).
- [ ] Handed back: what exists and where to look, what is left for the person, what I will do
      from now on, one question answerable in a word.
- [ ] Deleted nothing, changed no access without asking, imported nothing private.

## Sample conversation outline

**Check.** "You are connected as `<person>`, team `<team>` with `<n>` members and no projects.
What is the first piece of work you want to keep here? My guess: the thing you are working on
this month."

**Ask 1, the work.** "Is this one project, `<name>`? I recommend yes: one project with a
milestone for `<date>`." Person: "Yes, a launch in `<month>`."

**Ask 2, who.** "Is it just you, or should I add someone? I recommend just you for now; you can
add people later and I will ask first." Person: "Just me."

**Ask 3, progress.** "How do you want to see progress: a task list, or a short summary each
week? I recommend the task list to start." Person: "Task list."

**Build.** Search for an existing project of that name (none). Create `<project>`. One
`create_task_plan` (every task with `default_assignee_id` = the person): milestone "Launch `<month>`" with 5 tasks, `PRJ-2` after `PRJ-1`, `PRJ-4`
and `PRJ-5` after `PRJ-3`, and an order of work in the milestone body.

**Records.**
- Comment on `PRJ-1`: "Set up: project `<name>`, milestone `<title>`, 5 tasks. Not done: no
  group chat (you create it in the app)."
- Task note "How we work in Genos": what goes in tasks, comments and notes; you can edit or
  delete anything; I ask before changing access or deleting.
- Decision, said once: "Every decision becomes a note titled 'Decision: ...', with the reason.
  Just now we decided to track launch tasks in one project, so I saved that as 'Decision: track
  launch tasks in one project'. Edit or delete it if it is wrong."

**Hand back.**
1. Created: project `<name>` with milestone `<title>`, 5 tasks and 2 notes (find them in the
   project in the app).
2. For you: if you want a group chat for the launch, create it in the Genos app (the chat
   section).
3. From now on I record the work in tasks, comments and notes; you can read, edit and delete
   anything.

"Shall I start with `PRJ-1` now? yes/no, I recommend yes."

## When something is missing

| Situation | Do |
| --- | --- |
| Genos tools not available | Say how to connect (see `SKILL.md`, step 1); stop. Do not build a plan "in advance". |
| The team has no projects but several members | Still ask who is involved; adding members is a question, not a default. |
| The person wants a group chat | Tell them where in the app; offer to write the first message text in your reply. |
| The person wants to bring in work from elsewhere | Ask what and from where; import nothing private without a yes. |
| The person says "just set it up" | Build the smallest version from what you know, say what you assumed, and ask one question. |
