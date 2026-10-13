---
name: consolidate
description: Merge recent handoffs and decisions into memory/MEMORY.md. Run by the project owner or the weekly scheduled workflow, or when the user says "consolidate memory" or "update project state".
---

# Consolidate: rebuild the current project state

1. `git pull --rebase` on the default branch.
2. Read `memory/MEMORY.md`, `memory/NORTH_STAR.md`, `memory/ROSTER.md`.
3. Read every file in `memory/inbox/` except `_TEMPLATE.md`.
4. Read every file in `memory/decisions/` with `status: active`.
5. Rewrite `memory/MEMORY.md` keeping its section structure:
   - **Active decisions** table: one row per active decision. Drop superseded ones.
   - **Key facts**: add new facts from the inbox; remove ones a newer fact or decision replaced.
   - **Open questions**: add new ones; remove any answered in a later note or decision.
   - **Who is working on what**: latest focus per person from their newest note.
   - **Reusable prompts**: one row per file in `prompts/` except the template.
   - Update the "Last consolidated" line with today's date.
   - Keep it under 200 lines. Facts only. No narrative.
6. **Conflicts:** if two notes or decisions disagree, do NOT pick a winner. Add each to a
   `## Needs a decision` section at the top of MEMORY.md with both sources and the owner from ROSTER.md.
   A commercial decision beats a non-commercial note; flag it anyway.
7. Move each processed inbox file to `memory/archive/` (`git mv`).
8. Commit on branch `consolidate/<YYYY-MM-DD>`, push, open a PR titled
   `consolidate: <YYYY-MM-DD>`, listing in the description: new decisions, removed facts,
   conflicts needing a decision.
