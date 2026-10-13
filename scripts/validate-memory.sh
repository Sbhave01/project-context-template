#!/usr/bin/env bash
# Checks memory files are well-formed. Runs in CI on every PR; run locally too.
set -u
cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
fail=0
err() { echo "ERROR: $*"; fail=1; }

# 1. Decision files: required fields, valid values, immutable once merged
for f in memory/decisions/*.md; do
  [ -e "$f" ] || continue
  [ "$(basename "$f")" = "_TEMPLATE.md" ] && continue
  for key in id date area status approved_by author sensitivity; do
    grep -qE "^$key:[[:space:]]*[^[:space:]#]" "$f" || err "$f missing value for '$key'"
  done
  grep -qE '^status:[[:space:]]*(active|superseded)' "$f" || err "$f status must be active or superseded"
  grep -qE '^area:[[:space:]]*(commercial|product|marketing|dev|design|ops)' "$f" || err "$f area invalid"
  sup=$(grep -E '^supersedes:' "$f" | sed 's/supersedes:[[:space:]]*//;s/[[:space:]]*#.*//')
  if [ -n "$sup" ] && [ ! -f "memory/decisions/$sup.md" ]; then
    err "$f supersedes '$sup' but memory/decisions/$sup.md does not exist"
  fi
done

# 2. Merged decisions may only change their status line
if [ -n "${BASE_REF:-}" ]; then
  for f in $(git diff --name-only --diff-filter=M "origin/$BASE_REF"...HEAD -- memory/decisions/ 2>/dev/null); do
    other=$(git diff "origin/$BASE_REF"...HEAD -- "$f" | grep -E '^[+-][^+-]' | grep -vE '^[+-]status:' | wc -l | tr -d ' ')
    [ "$other" -gt 0 ] && err "$f: existing decisions are immutable — only 'status:' may change. Write a new superseding decision instead."
  done
fi

# 3. Obvious secrets
if grep -rInE '(sk-ant-[A-Za-z0-9_-]{10,}|sk-[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{30,}|-----BEGIN [A-Z ]*PRIVATE KEY-----)' memory prompts docs 2>/dev/null; then
  err "Possible secret found above. Remove it."
fi

# 4. Session IDs are useless to others
if grep -rInE '\bcse_[A-Za-z0-9]{10,}|\bsession_[A-Za-z0-9]{10,}' memory prompts 2>/dev/null; then
  err "Session IDs found above. Others can't open them — paste the prompt or link the output instead."
fi

[ $fail -eq 0 ] && echo "Memory OK" || exit 1
