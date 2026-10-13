#!/usr/bin/env bash
# Create a new project memory repo from this template.
# Usage: ./scripts/new-project.sh "<Project Name>" "<Client Name>" "<Owner Name>" [github-org]
# Example: ./scripts/new-project.sh "Kellix IQ" "Kellix" "Shivangi" mvp1-ventures
set -euo pipefail

PROJECT="${1:?Project name required}"
CLIENT="${2:?Client name required}"
OWNER="${3:?Owner name required}"
ORG="${4:-}"
SLUG=$(echo "$PROJECT" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9' '-' | sed 's/^-//;s/-$//')
REPO="${SLUG}-context"
TODAY=$(date +%F)
SRC="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$(pwd)/$REPO"

[ -e "$DEST" ] && { echo "$DEST already exists"; exit 1; }
mkdir -p "$DEST"
( cd "$SRC" && tar --exclude=.git -cf - . ) | ( cd "$DEST" && tar -xf - )

cd "$DEST"
# Fill placeholders (portable sed)
for f in $(grep -rl '{{' --include='*.md' --include='CODEOWNERS' . ); do
  sed -i.bak \
    -e "s/{{PROJECT_NAME}}/$PROJECT/g" \
    -e "s/{{CLIENT_NAME}}/$CLIENT/g" \
    -e "s/{{OWNER}}/$OWNER/g" \
    -e "s/{{DATE}}/$TODAY/g" -e "s/{{REPO}}/$REPO/g" "$f" && rm -f "$f.bak"
done
chmod +x scripts/*.sh

git init -q -b main
git add -A
git commit -q -m "init: $PROJECT shared project memory"

if [ -n "$ORG" ] && command -v gh >/dev/null; then
  gh repo create "$ORG/$REPO" --private --source=. --push
  echo "Created https://github.com/$ORG/$REPO"
else
  echo "Repo created locally at $DEST"
  echo "Push it:  gh repo create <org>/$REPO --private --source=. --push"
fi
echo "Next: fill memory/NORTH_STAR.md and memory/ROSTER.md, edit .github/CODEOWNERS, then follow SETUP.md."
