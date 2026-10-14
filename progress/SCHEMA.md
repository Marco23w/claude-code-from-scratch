# progress/<handle>.json

One file per learner, committed only on the learner's own branch `learner/<handle>`.

| Field | Type | Meaning |
|---|---|---|
| `handle` | string | GitHub login, lowercase. Set by `bin/setup.sh`. |
| `name` | string | Display name for the certificate. |
| `lang` | `en` or `it` | Language the tutor speaks and which lesson doc it reads (`docs/en.md` or `docs/it.md`). |
| `workspace` | path | The learner's own growth OS folder (default `~/Finanz/growth-os`). Exercises write there. |
| `channel` | string | The learner's growth area (meta, tiktok, aso, geo, ugc, markets...). Exercises use it. |
| `started` | date | ISO date of setup. |
| `current` | `00`..`09` or `done` | First phase not yet passed. Updated by `bin/done.sh`. |
| `xp` | int | 100 per phase passed, +50 for a perfect quiz. |
| `badges` | array | Badge keys unlocked, in order (see `badges.json`). |
| `lessons.<phase>` | object | `completed_at` (ISO), `check_passed` (bool), `attempts` (int, number of check runs), `minutes` (int, DERIVED: session minutes between the previous completion and this one), `quiz` (int, correct answers on the post quiz). |
| `capstone_review` | null or object | Set by `bin/done.sh 09` to `{"status":"pending"}`; flipped to `passed` or `redo` by Marco from `/corso-team`. |

# progress/<handle>.sessions.jsonl

One JSON line per Claude Code session opened in this repo: `sid`, `start`, `start_epoch`, `end`, `minutes`, optional `closed: "orphan"` when the end was reconstructed from the last heartbeat.

## What is logged, and what is not

Logged: timestamps, session ids, phase ids, check results, quiz scores, minutes. Not logged, ever: prompts, transcripts, file contents, the exercise files. The hooks receive a `transcript_path` from Claude Code and never read it. Minutes are session time, not attention: a session left open counts until the next heartbeat, so treat hours as an upper bound.
