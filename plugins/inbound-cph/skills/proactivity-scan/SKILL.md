---
name: proactivity-scan
description: Scan a client's live data and recent memory for anomalies, opportunities, and things the team should probably surface before the client does. Produce 3 ranked proactive recommendations with suggested next actions. Use when the user asks for proactivity, what's changing, what to flag, or says "scan <client>".
---

# proactivity-scan

Turn the agent into a proactive account manager. Read recent data + memory, find what's moving, decide what the team should bring to the client before the client brings it to us.

## When to use

Trigger phrases: "proactivity scan", "what should I flag", "what's changing for <client>", "anything Nordkap should hear from us", "scan <client>", "opportunities this week".

## Trin 0 — Kontekst (skal altid køres først)

Læs `${CLAUDE_PLUGIN_ROOT}/CLAUDE.md` før noget andet. Den indeholder write-gate-reglerne, kilde-attribution-formatet, sprog-reglerne, og hvordan Drive bruges.

## Trin 1 — Verificér Drive

Bekræft at du kan se Inbound-rod-mappen i Drive (ID `${user_config.inbound_root_folder_id}`, default `17JwnWKToZSJUSCURjS9PzzBeqe6_gPfi`). Hvis ikke, sig: "Jeg kan ikke nå Inbound's Drive-mappe. Tjek at du er logget ind på Drive i Cowork." og stop.

## Inputs (from Drive)

- `04-memory/client-memory.md` — context on what's been tried, what's worked, what's still open
- `05-data/*.csv` — latest metrics (weekly or monthly series)
- `01-brand/kpis.md` — what we're actually optimising for
- `06-decisions/*.md` — open decisions whose outcome we're measuring
- Connectors if available (Semrush MCP, GA4 via Sheets, Ads) — live where possible
- `03-meetings/*.md` — last 2 meetings (for tonal calibration)

## What to produce

Three ranked proactive items. Each has this shape:

### Item format

**Headline** — one line, concrete, grounded in data.

**What changed / what we're seeing** — 2-3 sentences of evidence. Cite the metric, the period, the delta. If it's qualitative (competitor movement, etc.), cite the source.

**Why it matters for this client** — 1-2 sentences. Connect to their stated priorities (from kpis.md) or strategic tensions (from brand.md).

**Suggested next action** — one concrete thing we propose doing or asking. Not "monitor" — something actionable this week or next.

**Confidence** — High / Medium / Low. High means data is unambiguous. Low means pattern-matching on limited signal.

## Ranking rules

Rank the three items by a blend of:
1. Materiality to the client's north-star KPI
2. Time-sensitivity (something decaying this week beats something that can wait)
3. Whether the client is likely to spot it themselves soon (higher rank if we get there first)

Do NOT rank by how easy they are to action. The point of proactivity is surfacing hard things early.

## Rules

- Lead with what's *moving*, not what's stable. Stable-and-good is not proactivity.
- Be honest about low-confidence patterns. Flag them as such. Don't dress up a hunch as a finding.
- Recommendations must be specific enough to act on. "Improve email" is not a recommendation. "Greenlight the re-permissioning campaign by Friday" is.
- If memory contains a prior recommendation that's still open, check whether this scan's findings strengthen or weaken that recommendation. Mention it.
- Always end output with `## Kilder` listing every Drive file you read, plus any live-connector pulls (Semrush, GA4, Ads) with the date of the pull. Format per `${CLAUDE_PLUGIN_ROOT}/CLAUDE.md` § Source attribution.
- **Drive write-back is human-in-the-loop. Never write to `client-memory.md` without explicit user approval.** After producing the three items, render the proposed one-line memory entry (date + three headlines + confidence levels, matching existing memory format) in a fenced code block, prefixed with: *"Proposed append to `04-memory/client-memory.md` — confirm to write, edit to revise, or say skip."* Wait for explicit approval (`yes` / `approve` / `confirm` / `write it`); silence and thumbs-up are not approval. Edits are approval — apply them then write. Only after approval, perform the Drive write and confirm back to the user. The user-confirmed append is what makes the context bank compound — but a write without confirmation is worse than no write at all.

## Example output shape

```
# Nordkap Friluft — proactivity scan (2026-04-20)

## 1. Hav & Fjeld now ranking top-3 on two pack queries [High]

**What:** Competitor SEO share data (2026-04-14 pull) shows Hav & Fjeld at position 3 on "letvaegts rygsaek" and "rygsaek vandretur" — both queries where Nordkap ranked 4-6 last month.

**Why it matters:** Pack category is Nordkap's second revenue anchor and had a surprise strong March (+22% YoY). We risk losing the halo.

**Next action:** Mette adds 8-query monitoring block on Hav & Fjeld pack terms; propose a defensive content brief to Sara next Monday.

## 2. Email open rate stabilising below target [Medium]
...

## 3. Category page flip — early signal window opens next week [Low]
...

## Kilder
- `nordkap-friluft/04-memory/client-memory.md` — pack category surge note (2026-03-28), email plateau context
- `nordkap-friluft/01-brand/kpis.md` — north-star (tent CVR), pack as second anchor
- `nordkap-friluft/05-data/semrush-2026-04-14.csv` — Hav & Fjeld pack-query rankings
- `nordkap-friluft/05-data/email-engagement-weekly.csv` — open rate trend
- `nordkap-friluft/06-decisions/2026-04-01-category-page-flip.md` — measurement window opens 2026-04-22

---
Appending to client-memory.md:
2026-04-20 — proactivity scan: (1) Hav & Fjeld pack pressure [H], (2) email plateau [M], (3) category page early-signal window [L]
```
