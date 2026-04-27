# inbound-cph-demo

Claude Code plugin marketplace for Inbound CPH's Kunde Specialist setup. Ships a single plugin (`inbound-cph`) with skills, operating rules, and company context, installed once per user, updated via `/plugin update`.

The companion Drive folder for the demo client is `nordkap-friluft/`. See `plugins/inbound-cph/CLAUDE.md` for the workspace shape skills expect.

## Install

In Cowork (or any Claude Code surface):

```
/plugin marketplace add CarlSvejstrup/inbound-cph-demo
/plugin install inbound-cph@inbound-cph-demo
```

Then run onboarding from inside a client folder:

```
/inbound-cph:onboard
```

Onboarding is a short Danish conversation. It writes a per-client `CLAUDE.md` (operating rules, active client) and a `guide.docx` (opslagsbog) into your workspace.

## Skills shipped

| Command | Purpose |
|---|---|
| `/inbound-cph:onboard` | Guided Danish setup, writes local CLAUDE.md + guide.docx |
| `/inbound-cph:client-brief` | One-page brief: brand, voice, KPIs, last 3 meetings |
| `/inbound-cph:proactivity-scan` | Three ranked proactive recommendations from data + memory |
| `/inbound-cph:weekly-pulse` | Two-minute weekly status delta |
| `/inbound-cph:voice-check` | Severity-ranked review of a draft against client voice |

## Philosophy

**Hard rule: human-in-the-loop on every write.** Every skill stops at "here's the draft, confirm to apply." The operating contract is in `plugins/inbound-cph/CLAUDE.md` and is loaded automatically when a skill runs (and always-on if the user ran `onboard` in their workspace).

**Reading is free, writing is gated.** Skills read aggressively across the client workspace without asking. The agent's value is synthesis. Approval is required only at the moment bytes leave the agent.

**Skills are code.** They live in version control, get reviewed, and distribute via the plugin update flow. No ad-hoc admin-console editing.

## Repo structure

```
.claude-plugin/
  marketplace.json              # marketplace manifest, lists the plugin
plugins/
  inbound-cph/
    .claude-plugin/
      plugin.json               # plugin manifest (name, version, description)
    CLAUDE.md                   # operating contract (loaded by skills)
    context/
      about-inbound.md          # company background
      drive-map.md              # Drive root + folder conventions
      voice-house-style.md      # Inbound's own house voice (not client voice)
    skills/
      client-brief/SKILL.md
      proactivity-scan/SKILL.md
      weekly-pulse/SKILL.md
      voice-check/SKILL.md
      onboard/
        SKILL.md
        templates/
          CLAUDE.md.template    # per-client local pointer (with <KUNDE> token)
          guide.md              # guide.docx source (markdown)
          guide.docx            # built artifact, copied into workspaces
scripts/
  build-guide.sh                # pandoc: guide.md → guide.docx
clients/
  nordkap-friluft/              # demo client outputs (not part of plugin)
docs/
  cowork-project-instructions.md
```

## Versioning + update flow

The plugin uses **explicit semver** in `plugins/inbound-cph/.claude-plugin/plugin.json`. Bump it every time you ship changes, pushing commits without bumping does nothing for users (Claude Code compares version strings, not SHAs).

After bumping and pushing:

1. Users open Cowork → marketplace panel.
2. Click `...` next to **`inbound-cph-demo`** marketplace → Refresh.
3. Plugin's "Update" button lights up → click.

If the marketplace metadata is stuck, the nuke-and-reinstall path:

```
/plugin marketplace remove inbound-cph-demo
/plugin marketplace add CarlSvejstrup/inbound-cph-demo
/plugin install inbound-cph@inbound-cph-demo
```

## Adding or editing a skill

```bash
# 1. Create the skill directory
mkdir -p plugins/inbound-cph/skills/<skill-name>
# 2. Write SKILL.md (frontmatter: name, description; body: when-to-use, inputs, what-to-produce, rules)
# 3. Bump plugins/inbound-cph/.claude-plugin/plugin.json version
# 4. Commit, push
# 5. Refresh marketplace + update in Cowork to test
```

Skill format follows Anthropic's universal SKILL.md spec, works across Cowork, Claude Code, Cursor, Codex.

## Editing the user-facing guide

The guide users see (`guide.docx`) is generated from markdown:

```bash
# Edit the source
$EDITOR plugins/inbound-cph/skills/onboard/templates/guide.md
# Rebuild the .docx
./scripts/build-guide.sh
# Bump plugin version, commit both files
```

Requires pandoc (`brew install pandoc`).

## Language and tone

The plugin defaults to **Danish** for all user interaction. English terms are preserved for marketing/tool vocabulary (SEO, ROAS, GA4, etc.). AI/ML jargon ("prompt", "context window", "embedding", etc.) is banned when explaining the system to users, they are marketers, not engineers. See `plugins/inbound-cph/CLAUDE.md` for the full language rules.

## Client workspace shape

Every client folder in the Inbound Drive follows this structure:

```
<client>/
  01-brand/        brand.md, voice.md, kpis.md
  02-past-reports/ historical deliverables
  03-meetings/     YYYY-MM-DD-<topic>.md
  04-memory/       client-memory.md  ← the moat
  05-data/         CSVs, Semrush exports, snapshots
  06-decisions/    YYYY-MM-DD-<topic>.md
```

If a client folder is missing one of these, surface it rather than scaffolding silently.

## Roadmap

- `/inbound-cph:capture` — lightweight append-to-memory skill for post-meeting hygiene
- `/inbound-cph:monthly-report` — graduate the existing `inbound-report` skill into this plugin
- `/inbound-cph:competitive-pulse` — Semrush + Ahrefs delta on competitor keyword movement

## Current version

See `plugins/inbound-cph/.claude-plugin/plugin.json`. Latest changes in commit log.
