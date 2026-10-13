#!/usr/bin/env bash
# Runs when Claude finishes a turn. If memory-relevant files changed but no handoff
# note was written today, prints a reminder. Never blocks.
cd "${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}" || exit 0
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

changed=$(git status --porcelain -- docs prompts memory/decisions 2>/dev/null | wc -l | tr -d ' ')
today=$(date +%F)
note=$(git status --porcelain -- memory/inbox 2>/dev/null | grep "$today" | wc -l | tr -d ' ')

if [ "$changed" -gt 0 ] && [ "$note" -eq 0 ]; then
  echo "[memory] You have uncommitted project changes and no handoff note today. Run /handoff before you close." >&2
fi
exit 0
