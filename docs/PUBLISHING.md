# Publishing skills to Claude Projects

The repo is the source of truth. Skills reach end-users via two paths.

## Path A — Cowork (power users, instant)

`scripts/sync-to-cowork.sh` handles this. Run manually, or install as a LaunchAgent timer. On each run:

1. `git pull --ff-only origin main`
2. Symlink each `skills/<name>/` into the local Cowork skills folder

Power users have the latest `main` on their Cowork without touching the admin console.

## Path B — Claude Projects (team, weekly cadence)

Projects don't currently support direct git sync (as of April 2026). Publishing is manual:

1. Every Monday, Ian opens the Claude admin console
2. For each new or changed skill since last publish, upload the latest `SKILL.md` + any dependencies
3. Verify the skill appears in the target Projects
4. Announce in Slack what shipped this week

This adds one weekly action (~15 min). Accept it for now. Anthropic's admin API for programmatic skill publishing is expected to mature during 2026; switch to automated publishing when it does.

## Release cadence

- `main` is always deployable
- Merges happen daily when ready
- Weekly publish to Projects happens Monday at 10:00 local
- Emergency skills (bug fixes) can be Cowork-synced immediately; Projects update on the next publish

## Rollback

- Cowork: `git revert`, next sync picks it up
- Projects: re-upload the previous version of the `SKILL.md` via admin console. Keep a history of tagged releases (`v0.1`, `v0.2`) so "previous version" is obvious.

## Versioning

- Tag releases when a set of related changes land (`git tag v0.2 && git push --tags`)
- Each skill folder can optionally include a `CHANGELOG.md` if its behaviour is changing meaningfully
