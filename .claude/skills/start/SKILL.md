---
name: start
description: Run at the start of a session on this project, or when the user says "catch me up", "where are we", or asks about project state. Loads shared memory and briefs the user.
---

# Start: load shared project memory

1. Run `git pull --rebase` (skip if not a git checkout, e.g. working through the GitHub connector — then read the files from the default branch).
2. Read, in order:
   - `memory/NORTH_STAR.md`
   - `memory/MEMORY.md`
   - `memory/ROSTER.md`
   - every file in `memory/inbox/` newer than the "Last consolidated" date in MEMORY.md (these are recent handoffs not yet merged)
3. Ask the user (one question) what they're working on today if they haven't said.
4. Read every `memory/decisions/` file with `status: active` whose `area` or `affects` matches that work.
5. Reply with a brief of at most 10 lines:
   - What's current that matters for their task
   - Active decisions they must respect (name the files)
   - Recent handoffs from others that touch their task
   - Open questions they might be able to answer
   - Any existing prompt in `prompts/` they should reuse
6. Then start the work.
