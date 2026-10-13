---
name: handoff
description: Run at the end of any session where something was decided, learned, built, or left open — or when the user says "wrap up", "save this", "hand off", "push to memory". Writes this session's memory to the shared repo so every other person's agent can carry it forward.
---

# Handoff: write this session into shared memory

Write facts, not narrative. Someone who wasn't here must be able to continue from it.

1. **Decisions.** For anything finalized this session that has no decision file yet, follow the
   `/decide` steps for each one. Ask the user to confirm anything you're unsure is final.

2. **Prompts.** If a prompt produced something worth keeping (an artifact, a doc, an analysis,
   designs, copy, code approach), save the final working version verbatim to
   `prompts/<slug>.md` using `prompts/_TEMPLATE.md`. Include what was tried and dropped.

3. **Outputs.** For anything produced, record where it lives: repo path, artifact link,
   Drive link, Figma link. Never write "see my session" — session IDs are private.

4. **Session note.** Create `memory/inbox/<YYYY-MM-DD>-<author>-<slug>.md` from
   `memory/inbox/_TEMPLATE.md`. Fill every section; write "none" rather than leaving blank.
   Keep it under 40 lines.

5. **Show the user** the session note and ask: "Anything wrong or missing?" Fix, then continue.

6. **Push.**
   ```
   git checkout -B handoff/<author>-<YYYY-MM-DD>
   git add memory/ prompts/ docs/
   git commit -m "handoff: <author> <slug>"
   git push -u origin HEAD
   gh pr create --fill --label handoff
   ```
   Working through the GitHub connector instead of git: create the same files on a new branch
   `handoff/<author>-<YYYY-MM-DD>` and open a pull request titled `handoff: <author> <slug>`.

7. Reply with the PR link and one line on what's now in shared memory.
