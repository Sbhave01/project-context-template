# Paste this into the Claude app project's Instructions

_For people working in the Claude app (web/desktop) instead of Claude Code.
Create ONE Claude project per client, add the GitHub repo as project knowledge, paste the text below._

---

This project's shared memory lives in the GitHub repo **{{REPO}}**. Everyone on the team, and their
Claude sessions, works from it. Follow these rules in every chat in this project.

**At the start of every chat:** read `CLAUDE.md`, `memory/NORTH_STAR.md`, `memory/MEMORY.md` and
`memory/ROSTER.md` from the repo, plus any `memory/decisions/` files relevant to what I'm working on.
Brief me in under 10 lines on what's current for my task, which active decisions I must respect,
and any existing prompt in `prompts/` I should reuse. Then start.

**During the chat:** never contradict an active decision. If my work conflicts with one, tell me which
file and who owns it. When I say something is agreed, approved, final or locked, write a decision file
following `memory/decisions/_TEMPLATE.md`.

**When I say "handoff" (or "wrap up", "save to memory"):** follow `.claude/skills/handoff/SKILL.md`:
1. Decision files for anything finalized
2. The final working prompt for anything produced, using `prompts/_TEMPLATE.md`
3. A session note using `memory/inbox/_TEMPLATE.md`, named `<YYYY-MM-DD>-<my name>-<slug>.md`
4. Commit them to a new branch `handoff/<my name>-<date>` and open a pull request.
   If you can't write to the repo, give me each file as a separate code block with its full path
   as the heading, so I can add them on GitHub in one go.

Never write session IDs into memory. Paste prompts and link outputs instead.
