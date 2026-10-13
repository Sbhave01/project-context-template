# Project Context — read this first

This repo is the shared memory for **{{PROJECT_NAME}}**. Every person's Claude session
(Claude Code, Claude app, any agent) works from this repo, so everyone starts from the
same state. If it isn't written here, other people's agents don't know it.

## Start of every session
1. Pull latest (`git pull`). Claude Code does this automatically via the session hook.
2. Read `memory/MEMORY.md` — the current state of the project.
3. Read any file in `memory/decisions/` relevant to today's task.
4. Read `memory/ROSTER.md` to know who owns what.
5. Check `prompts/` before writing a new prompt for something that may have been done before.

## While working
- **Never contradict an active decision.** If the work needs to change one, stop and say so:
  "This conflicts with decision <file>. Owner is <name>. Want me to draft a superseding decision?"
- When something is finalized during the session (approved, agreed, locked), run `/decide`
  right then. Don't wait for the end.
- Strategy and commercial decisions (`area: commercial`) take precedence over product,
  marketing and dev decisions when they conflict.

## End of every session
Run `/handoff` if anything was decided, learned, built, or left open. A session with no
handoff is invisible to the rest of the team.

## Rules for writing to memory
- Write facts and finalized decisions only. No brainstorming, no half-ideas.
- One file per decision in `memory/decisions/`. Never edit an old decision; supersede it.
- Session notes go in `memory/inbox/` as new files. Never edit someone else's inbox file.
- Only `/consolidate` (run by the project owner or the scheduled workflow) edits `memory/MEMORY.md`.
- Never write secrets, passwords, API keys, or personal data about individuals.
- Commercially sensitive numbers (pricing, margins, negotiation positions) go only in
  `memory/decisions/` with `sensitivity: restricted`, or in the separate restricted repo if one exists.

## Folder map
| Path | What lives there | Who writes |
|---|---|---|
| `memory/MEMORY.md` | Current project state | `/consolidate` only |
| `memory/NORTH_STAR.md` | The one goal everything serves | Project owner |
| `memory/ROSTER.md` | Who owns what, humans and agents | Project owner |
| `memory/decisions/` | Finalized decisions, immutable | Anyone via `/decide` |
| `memory/inbox/` | Per-session handoff notes | Anyone via `/handoff` |
| `memory/archive/` | Processed inbox notes | `/consolidate` |
| `prompts/` | Reusable prompts that worked | Anyone via `/handoff` |
| `docs/` | Specs, briefs, client material | Anyone |
