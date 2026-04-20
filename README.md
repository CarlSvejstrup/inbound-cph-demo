# inbound-skills

Git-backed skill library for Inbound CPH's Claude setup. Source of truth for every skill the team uses, across Claude Projects and Claude Cowork.

## Philosophy

**Skills are code.** They live in version control, get PR-reviewed, and distribute from here to every surface that uses them. This replaces ad-hoc admin-console editing with engineering discipline.

## Structure

```
skills/
  client-brief/
    SKILL.md          # the skill definition (universal Anthropic format)
    scripts/          # supporting Python/bash if needed
    examples/         # example inputs and expected outputs
  proactivity-scan/
    ...
  weekly-pulse/
    ...
scripts/
  sync-to-cowork.sh   # pulls main + symlinks into local Cowork skills folder
docs/
  CONTRIBUTING.md     # how to add or modify a skill
  PUBLISHING.md       # how skills get from here to Projects
```

## How skills flow to users

1. **Author a skill locally** in a branch. Test it in Cowork against a real client Drive folder.
2. **Open a PR.** CODEOWNERS review. Any skill that touches client data or external APIs needs Ian's approval.
3. **Merge to `main`.**
4. **Cowork users** run `sync-to-cowork.sh` (or it runs on a LaunchAgent timer) — skill updates are live immediately.
5. **Projects users** get the update on the weekly publish cadence — Ian publishes to the org's admin console every Monday.

## Requirements

- Git (obviously)
- Anthropic universal SKILL.md format — works across Cowork, Claude Code, Cursor, Codex
- Python 3.11+ for any script-backed skills

## Quickstart for a new skill author

```bash
cd ~/code/personal/inbound-skills
git checkout -b add-<skill-name>
cp -r skills/_template skills/<skill-name>
# edit skills/<skill-name>/SKILL.md
# test in Cowork
git add skills/<skill-name>
git commit -m "add <skill-name> skill"
git push -u origin add-<skill-name>
# open PR
```

## Current skills (v0.1)

| Skill | Purpose |
|---|---|
| `client-brief` | Synthesise brand + history + memory + last 3 meetings into a one-page client brief |
| `proactivity-scan` | Read live data + memory, flag anomalies, draft 3 proactive recommendations |
| `weekly-pulse` | 2-minute status: what moved, what's at risk, what the client will ask about |

## Roadmap

- `/capture` — lightweight append-to-memory skill for post-meeting hygiene
- `/client-report-monthly` — graduate the existing `inbound-report` skill into this library
- `/new-client-onboarding` — scaffolds a new client's Drive folder + Project from templates
