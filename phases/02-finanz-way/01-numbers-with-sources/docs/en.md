# The Finanz way: numbers with sources

> A number without a source is a rumour. Label it, source it, or write "no data". No third option :)

**Badge:** 🔎 Source Hunter  ·  **Time:** ~1 h 30  ·  **Prerequisites:** phase 01

## What you'll be able to do
- Label every figure MEASURED, DERIVED or ASSUMED, and say where it was read.
- Write a STATUS.md for your channel: target vs actual, owner, next action, machine-readable header.
- Make Claude refuse to invent a number.

## The Problem
Claude is fluent. Ask "how did TikTok do this week?" and it will give you a confident paragraph
with numbers in it. Some read from a file, some computed, some... plausible. Downstream nobody can
tell which is which, and a plausible figure in a weekly report becomes a decision on Monday.

Marco's rule, verbatim from his CLAUDE.md: "Every number, metric, ID, name, quote or attribution
that enters a report, a decision or a write must have a source Marco can reopen." This phase is
that rule, made into a file.

## The Concept
Three labels, always visible:
```
MEASURED   read from a source   -> "12.4% install->account, Mixpanel funnel X, W41"
DERIVED    computed from measured inputs -> "CPU 0.74 EUR = spend (Meta) / accounts (Mixpanel)"
ASSUMED    neither              -> "3h per phase (ASSUMED, to calibrate on pilots)"
no data    the honest fourth    -> and what is needed to get it
```
And one file per project that holds the state, `STATUS.md`:
```
---
last-updated: 2026-10-14     <- machine-readable: a script flags you when it's stale
review-interval: 7d
owner: <you>
---
## Target vs actual   <- a table: KR | Target | Actual | Status label | Source | As of
## Next action        <- one line, owner, date
```
Every project in Marco's workspace has one. A cockpit skill reads all of them in one go.

## Build It
### Step 1: pick three KRs
For your channel, this quarter. Real ones. If you don't have a target, write the target you'd
defend and label it ASSUMED. That's allowed. Inventing an actual is not.

### Step 2: hunt the actuals
For each KR, find the number where it lives (Adjust, Mixpanel, the Engine, a sheet). Write down
the exact place: tool, report name, filter, date. If you can't reach the source today: "no data",
plus what's needed ("needs Mixpanel access to funnel X").

### Step 3: write STATUS.md
Ask Claude: "create STATUS.md from reference/STATUS_template.md with my three KRs". Give it the
numbers AND the sources. Then read every row: does each Actual carry MEASURED / DERIVED /
ASSUMED or "no data"? Does each Source let a teammate reopen it?

### Step 4: try to break it
Ask Claude: "add the install-to-account rate for last week" without giving a source. The right
answer is a question back, or "no data". If Claude writes a number, your CLAUDE.md from phase 01
needs one more line under "Where numbers come from". Add it. Try again.

### Step 5: date it
`last-updated` is today, `review-interval` is 7d. In phase 08 a hook will nag you when it's stale.

## Use It
Marco's Meta Ads STATUS.md has a KR row that reads: "Testing restock | 2 new creatives/week per
language | no data (queue empty on 2026-09-10) | `paid_ads_creative_queue` | 2026-09-10". No data,
with the source and the date. That row is more useful than a made-up "on track".

## Ship It
`STATUS.md` in your workspace. From now on every exercise updates it, and the capstone is judged on it.

## Check
`bin/check.sh 02` verifies: STATUS.md exists · `last-updated:` ISO date · `review-interval: Nd` ·
KR table with a Source column · at least 3 rows · every row labelled MEASURED / DERIVED / ASSUMED
or "no data".

## Key Terms
| Term | What people say | What it actually means |
|---|---|---|
| MEASURED | "the real number" | Read from a named source at a named time. Nothing else qualifies. |
| DERIVED | "calculated" | Computed from MEASURED inputs with a formula you can show. |
| ASSUMED | "estimate" | Neither. Allowed, as long as it says so. |
| no data | "we don't know" | The honest cell. Always followed by what is needed to fill it. |
| Canonical definition | "the metric" | The one agreed formula (e.g. CPU = paid spend / new accounts). Changing it silently breaks every report. |

## Further Reading
- `reference/finanz-way.md` in this repo: the ten house rules, one page.
