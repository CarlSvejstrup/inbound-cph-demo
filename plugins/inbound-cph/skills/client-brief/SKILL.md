---
name: client-brief
description: Generate a one-page briefing on a client by synthesising brand, voice, KPIs, client-memory.md, and the last 3 meetings. Use when the user asks for a client brief, handover doc, pre-meeting prep, or says "brief me on <client>".
---

# client-brief

Produce a grounded one-page brief on the active client.

## When to use

Trigger phrases: "brief me on", "client brief", "prep for <client>", "what should I know before my call with <client>", "handover doc for <client>".

## Inputs (pulled from the client's workspace)

- `01-brand/brand.md` — positioning, target customer, strategic context, priorities
- `01-brand/voice.md` — editorial voice rules
- `01-brand/kpis.md` — metrics that matter, current values, Q-level targets
- `04-memory/client-memory.md` — rolling institutional memory (newest first)
- `03-meetings/*.md` — last 3 meeting notes by date
- `06-decisions/*.md` — any decision whose measurement window is still open

## What to produce

A single markdown page, structured as:

### 1. One-line state of the client
Write one sentence that would make a specialist who has never met this client usable in 30 seconds. Lead with the most important current tension.

### 2. North-star + current position
Quote the north-star metric from `kpis.md`. Give current value. State whether it's on/off track for the target, in one line.

### 3. What's working
Two or three bullets. Pull from recent meeting headlines and wins. Attribute specifically (which decision, which month).

### 4. What's at risk
Two or three bullets. Pull from concerns in the memory and decisions whose success criteria are still pending. Be specific about *why* the risk matters.

### 5. Open recommendations
List every open recommendation from the last 3 meetings. For each: status (landed / pending client action / blocked), who's the blocker, when it was first proposed.

### 6. What the client (Sara, Ian, whoever) will probably ask about next
Based on memory tone and meeting cadence. One or two lines. Make a judgment call.

### 7. Voice reminder
One sentence from `voice.md` about do/don't. Keeps any draft copy on-tone.

## Rules

- Never invent data. If memory doesn't cover something, say "not in memory" — don't hallucinate continuity.
- Stay on-voice for the client. Read `voice.md` before writing any direct-quote-worthy lines.
- Max 1 page. If it runs long, cut recommendations first.
- Lead with conclusions. No preamble, no "here is your brief" framing.
- Do not update `client-memory.md` from this skill — reading only.

## Example output shape

```
# Nordkap Friluft — client brief (2026-04-20)

Tent PDP rework worked (CVR 0.82% → 0.96%). Now chasing 1.0% target for Q2.
Email engagement declining three months running — next battle.

## North-star
Tent CVR ≥ 1.0% by end of Q2. Currently 0.95%. On track.

## Working
- PDP rework on top-3 tents lifted CVR ~0.14pp (shipped 2026-02-18)
- Organic non-branded traffic at 52k sessions, growing steadily
- Pack category +22% YoY (likely photography halo)

## At risk
- Email open rate 19.5% vs 28% target — three months declining
- Blended ROAS slipping to 3.2x, Meta side weakening
- Hav & Fjeld competitor now on pack queries (new vector)

## Open recommendations
- Re-permission email campaign — pending Sara greenlight since 2026-02
- Category page flip — shipped 2026-04-01, too early to measure
- Pricing experiment on tent SKU — blocked on Nordkap CFO for 2 months

## Probably the next question from Sara
Whether the April category-page data shows any early signal. Answer: 2 weeks in, too early. Hold to the data.

## Voice reminder
Understated. No hype. "Three weeks in" beats "a promising start."
```
