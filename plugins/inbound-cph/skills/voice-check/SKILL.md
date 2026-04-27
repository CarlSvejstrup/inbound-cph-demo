---
name: voice-check
description: Review a draft (email, ad copy, post, report section, brief) against the client's brand voice and flag deviations with severity-ranked rewrites. Use when the user asks for a voice check, tone review, on-brand review, or says "is this on voice for <client>", "check this against <client>'s voice", or pastes a draft and asks "does this sound like them".
---

# voice-check

Police a draft against the client's editorial voice. Catch hype, off-tone phrasing, banned words, and structural drift before it leaves the agency.

## When to use

Trigger phrases: "voice check", "tone check", "is this on voice", "does this sound like <client>", "review this draft for <client>", "on-brand review", "on-voice review".

The user provides a draft (pasted in chat, or a file path inside the client workspace). The skill reviews it; it does not write the draft.

## Inputs (pulled from the client's workspace)

- `01-brand/voice.md` — editorial voice rules (do/don't, banned words, register, sentence shapes)
- `01-brand/brand.md` — positioning context, so voice judgments are grounded in strategy not just style
- `04-memory/client-memory.md` — permanent notes, especially any "voice deviation patterns" learned from past reviews

## What to produce

A single review, structured as:

### 1. Verdict
One line: `On voice` / `Mostly on voice, minor fixes` / `Off voice, rewrite needed` / `Wrong register entirely`.

### 2. Severity-ranked findings
A table with three columns: Severity (`high` / `medium` / `low`), Issue, Where (line or quoted phrase from the draft).

- `high` = breaks an explicit rule in `voice.md` (banned word, banned construction, wrong register)
- `medium` = drifts from the spirit of the voice (hype creeping in, vague claim, generic agency-speak)
- `low` = stylistic polish (rhythm, sentence length, word choice that's fine but could be sharper)

### 3. Before/after rewrites
For every `high` and `medium` finding, show the original phrase and the rewritten version. The rewrite must be in the client's voice, quote `voice.md` specifics if it helps the user see the reasoning.

### 4. Voice reminder
One sentence from `voice.md` that captures the underlying principle the draft missed. Keeps the next draft on-tone.

## Rules

- Never rewrite the whole draft. Only the flagged phrases. The user owns the draft; the skill audits it.
- If `voice.md` is missing or sparse, say so explicitly and review against `brand.md` positioning only, do not invent voice rules.
- Be honest about `On voice` verdicts. If a draft is fine, say it is fine. Padding the findings to look thorough is itself off-voice for an agency.
- Lead with the verdict. No preamble.
- This skill is read-only by default. If a recurring deviation pattern emerges (e.g. the same hype word appears in three drafts), propose a one-line append to `04-memory/client-memory.md` under "Voice deviation patterns", but follow the standard write-gate: draft, render the proposal, wait for explicit approval, then write.

## Example output shape

```
# Voice check — Nordkap Friluft email draft (2026-04-27)

**Verdict:** Mostly on voice, minor fixes.

## Findings

| Severity | Issue | Where |
|---|---|---|
| high | "Game-changing" — banned hype word per voice.md | Line 1: "Our game-changing new tent..." |
| medium | Vague claim, no evidence | Line 4: "customers love it" |
| low | Sentence length drift, three 30+ word sentences in a row | Lines 7-9 |

## Rewrites

**Line 1 — high**
- Before: "Our game-changing new tent collection is here."
- After:  "The 2026 tent collection is in stock."
- Why: voice.md says "no superlatives, lead with the fact."

**Line 4 — medium**
- Before: "customers love it"
- After:  "92% of early buyers re-rated it 5 stars after one trip"
- Why: voice.md says "evidence over enthusiasm."

## Voice reminder
Nordic restraint. The fact does the work. Three weeks in, not "a promising start."
```
