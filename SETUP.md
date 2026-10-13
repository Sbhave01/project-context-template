# Setup — shared project memory for a team of 4–5

One repo per client project. Everyone's Claude reads it at the start of a session and writes
back to it at the end. No more "can you share your session?"

---

## Part 1 — Project owner (once per project, ~20 min)

**1. Create the repo**
```bash
git clone <this-template-repo> project-context-template
cd <where you keep projects>
./project-context-template/scripts/new-project.sh "Kellix IQ" "Kellix" "Shivangi" <your-github-org>
```
This creates a private repo `kellix-iq-context` with all placeholders filled in.
(No template repo yet? Unzip this folder, `cd` into it, `git init`, push it as `project-context-template`,
and tick **Settings → Template repository** on GitHub.)

**2. Fill in the three human-owned files**
- `memory/NORTH_STAR.md` — one measurable goal
- `memory/ROSTER.md` — names, roles, GitHub handles
- `memory/MEMORY.md` — the Client section and current goals

**3. Edit `.github/CODEOWNERS`** — replace `@Shivangi` with your real GitHub handle.

**4. GitHub settings**
- **Collaborators:** Settings → Collaborators → add the 4–5 people (Write access).
- **Branch protection on `main`:** Settings → Branches → Add rule →
  - Require a pull request before merging (1 approval)
  - Require review from Code Owners
  - Require status checks: `validate`
- **Labels:** create a label `handoff`.
- **Auto-delete branches:** Settings → General → Automatically delete head branches.

**5. Weekly consolidation (optional but recommended)**
Settings → Secrets and variables → Actions → New secret `ANTHROPIC_API_KEY`.
It runs every Monday 8am Brisbane and opens a PR updating `MEMORY.md`. You review and merge.
Prefer not to use an API key? Run `/consolidate` yourself in Claude Code each Monday instead.

**6. Seed it with what already exists.** Open Claude Code in the repo and say:
> "Here are my existing notes and the commercial assessment for this client: [paste or attach].
> Turn the finalized decisions into decision files, the facts into MEMORY.md, then /handoff."

Do the same with the product and marketing teams' existing Claude projects: each person pastes
their project's key docs and runs `/handoff`. That merges the 3 separate projects into one.

---

## Part 2 — Each team member (once, ~5 min)

### If you use Claude Code (devs, designers, anyone technical)
```bash
git clone git@github.com:<org>/kellix-iq-context.git
cd kellix-iq-context
claude
```
That's it. The session hook pulls latest memory and loads it automatically.
The skills `/start`, `/decide`, `/handoff`, `/consolidate` are available immediately.

**Dev repos too:** in your code repo's `CLAUDE.md`, add one line:
```
Shared project memory: read ../kellix-iq-context/CLAUDE.md and follow it. Run /handoff from there at the end.
```
Or run Claude Code from the code repo with the context repo added:
`claude --add-dir ../kellix-iq-context`

### If you use the Claude app (commercial, product, marketing)
1. **One project per client, shared.** The owner creates it in the Claude app; everyone else joins
   it instead of making their own. (On a Team/Enterprise plan, share it with the team.)
2. In the project: **Add content → GitHub** → pick `kellix-iq-context` (connect GitHub first if asked).
3. **Project instructions:** paste the contents of `docs/claude-app-project-instructions.md`
   (replace `{{REPO}}` with the repo name).
4. At the end of a chat, type **"handoff"**. If Claude gives you files instead of a PR link:
   GitHub → repo → **Add file → Upload files** (or Create new file), paste each one at its path,
   choose **Create a new branch**, Propose changes. Takes about a minute.

> Project knowledge from GitHub is a snapshot. Before starting a chat, open project knowledge
> and hit **Sync** on the repo so you're reading the latest memory.

---

## Part 3 — Daily rhythm

| When | Who | What |
|---|---|---|
| Start of session | Everyone | `/start` (auto in Claude Code) — 10-line brief |
| Something gets agreed | Whoever is in the room | `/decide` — same day, including decisions from calls |
| End of session | Everyone | `/handoff` — opens a PR |
| Same day | Any teammate | Review and merge handoff PRs. Commercial decisions: owner approves |
| Monday | Owner / scheduled workflow | `/consolidate` — review the PR, resolve "Needs a decision" |
| Monday | Whole team, 15 min | Retro: what's wrong or missing in memory? Fix it with `/handoff` |

## The four rules
1. **If it isn't in the repo, it didn't happen.** Decisions from calls, Slack and DMs get a `/decide` the same day.
2. **One project, one repo.** Never start a separate Claude project for a client that has one.
3. **No session IDs.** Paste the prompt into `prompts/`, link the output.
4. **Decisions are immutable.** To change one, write a new one that supersedes it.

## Troubleshooting
| Problem | Fix |
|---|---|
| Claude didn't read memory | Say `/start`. In the Claude app, re-sync project knowledge first. |
| Handoff PR fails `validate` | Read the error in the PR checks; usually a missing field in a decision file. |
| Two people decided different things | Consolidation lists it under "Needs a decision"; the owner in ROSTER.md resolves it with `/decide`. |
| Push rejected | `git pull --rebase` then push again. Inbox files never conflict. |
| Memory is getting long | That's what `/consolidate` is for; old inbox notes move to `memory/archive/`. |
