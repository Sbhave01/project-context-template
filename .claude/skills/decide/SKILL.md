---
name: decide
description: Record a finalized decision the moment it's made — when the user says something is agreed, approved, locked, final, "let's go with", or a client confirmed it. Writes one immutable decision file.
---

# Decide: record a finalized decision

Only record things that are actually final. If it's still being discussed, say so and don't write.

1. Confirm with the user in one line: the decision, who approved it, and its area.
2. Check `memory/decisions/` for an active decision it changes or replaces.
   - If one exists: the new file gets `supersedes: <old id>`, and change only the old file's
     `status:` line to `superseded`. Change nothing else in the old file.
3. Create `memory/decisions/<YYYY-MM-DD>-<slug>.md` from `memory/decisions/_TEMPLATE.md`.
   Fill every field. `affects` lists which teams must know.
   If it contains pricing, margins or negotiation positions, set `sensitivity: restricted`.
4. Commit on the current handoff branch (or create `handoff/<author>-<YYYY-MM-DD>`):
   `git add memory/decisions/ && git commit -m "decision: <slug>"`
5. Tell the user the file path and which teams it affects.
