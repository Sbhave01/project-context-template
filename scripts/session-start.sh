#!/usr/bin/env bash
# Runs at the start of every Claude Code session in this repo.
# Pulls latest shared memory and puts the current state into the session's context.
cd "${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}" || exit 0

git pull --rebase --quiet >/dev/null 2>&1 || echo "[memory] Could not pull latest — you may be working on stale memory. Run: git pull"

echo "=== SHARED PROJECT MEMORY (pulled at session start) ==="
for f in memory/NORTH_STAR.md memory/MEMORY.md; do
  [ -f "$f" ] && { echo; echo "----- $f -----"; cat "$f"; }
done

recent=$(ls memory/inbox/*.md 2>/dev/null | grep -v _TEMPLATE)
if [ -n "$recent" ]; then
  echo
  echo "----- Unconsolidated handoffs (read the ones relevant to today's task) -----"
  echo "$recent"
fi
echo
echo "Before working: read active decisions in memory/decisions/ relevant to the task. At the end: run /handoff."
exit 0
