---
name: onboard
description: Onboard a new Inbound CPH user to the Kunde Specialist setup. Tours the plugin (skills, context, write-gate rule), points to the Drive workspace shape, and optionally writes a project-local CLAUDE.md for a specific client folder. Use when a new colleague says "I just installed this", "how do I get started", "onboard me", "what does this plugin do", or "set me up for <client>".
---

# onboard

Walk a new Inbound CPH user through the Kunde Specialist setup so they can run their first client workflow within ten minutes.

## When to use

Trigger phrases: "onboard me", "I just installed inbound-cph", "how do I get started", "what does this plugin do", "set me up", "first time using this", "show me around".

## What to do

Run the four steps below in order. Read aloud (in chat) what each section covers so the user sees the structure, then ask if they want to continue or skip ahead.

### 1. Read the operating contract

Read `${CLAUDE_PLUGIN_ROOT}/CLAUDE.md` and summarise the three rules that matter most:
- Human-in-the-loop on every write
- Reading is free, writing is gated
- Voice rules per client (read `01-brand/voice.md` before drafting)

Confirm the user has read the summary before continuing.

### 2. Tour the company context

Read `${CLAUDE_PLUGIN_ROOT}/context/about-inbound.md`, `drive-map.md`, and `voice-house-style.md`. Summarise each in two lines. Tell the user these files load automatically whenever the plugin is active, so they do not need to re-read them every session.

### 3. List the skills

List the skills in this plugin with their one-line descriptions:
- `client-brief` — synthesise a one-page brief on a client
- `proactivity-scan` — three ranked proactive recommendations
- `weekly-pulse` — two-minute weekly status delta
- `voice-check` — review a draft against client brand voice
- `onboard` — this skill

Tell the user how to invoke them (`/inbound-cph:client-brief`, etc.).

### 4. Optional — write a project-local CLAUDE.md

Ask: "Are you working from a specific client folder right now? If yes, I can write a short project-local CLAUDE.md that pins this client as the active workspace and reminds future sessions of the operating rules."

If yes, ask for the client name, draft the file content, and follow the standard write-gate (draft, render proposal, wait for explicit approval, write).

The project-local CLAUDE.md should be short:

```
# CLAUDE.md — <client> workspace

Active client: <client>
Drive path: <client folder name in Inbound Drive>

This workspace operates under the Inbound CPH plugin operating contract.
See ${CLAUDE_PLUGIN_ROOT}/CLAUDE.md for the full rules.

Quick reminders:
- Every external write needs explicit user approval
- Read 01-brand/voice.md before drafting any client-facing copy
- Update 04-memory/client-memory.md only via the gated write pattern
```

## Rules

- Do not write anything in steps 1, 2, or 3. Those are read-only tours.
- Step 4 writes only with explicit approval, scoped to the exact path shown.
- Never write to `~/.claude/CLAUDE.md` (global). This skill is project-local only. If the user wants a global install, point them to copying `${CLAUDE_PLUGIN_ROOT}/CLAUDE.md` themselves.
- Keep the tour tight. The user is onboarding, not reading a manual. Two-line summaries, not paragraphs.
