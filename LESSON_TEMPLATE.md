# Lesson template

Copy `phases/00-first-session/01-hello-claude/` and fill in. Same shape everywhere, so the
tutor and the learner always know where they are.

```
phases/NN-phase-name/01-lesson-name/
├── docs/en.md        the lesson, English (Marco's tone)
├── docs/it.md        the lesson, Italian (same headings, same order)
├── quiz.json         questions: stage "pre" (1-2) and "post" (3-4), options, correct index, explanation
├── check.sh          the machine check: sources bin/checklib.sh, one line per criterion, exit 0 on pass
└── outputs/          templates and snippets the lesson ships (what the learner keeps)
```

## docs/<lang>.md

```markdown
# [Title]

> [Motto: the one line that sticks]

**Badge:** [emoji] [name]  ·  **Time:** ~[n] min  ·  **Prerequisites:** phase [NN]

## What you'll be able to do
- three lines, verbs first

## The Problem
What hurts today without this. A real growth-team scenario, 2 short paragraphs.

## The Concept
The mental model. One ASCII diagram. No code yet.

## Build It
### Step 1: ...
What to type, what to expect. The learner does it in their workspace.
### Step 2: ...

## Use It
How Marco uses this exact thing in his workspace (real path, real example, no secrets).

## Ship It
The artifact the learner keeps, and where it now lives.

## Check
What `bin/check.sh NN` verifies, line by line. No surprises.

## Key Terms
| Term | What people say | What it actually means |

## Further Reading
- official docs link, one line on why
```

Rules: every number with a source; no secrets, no IDs in examples; emojis in prose only, never
in code blocks; Italian version is a translation of the same structure, not a different lesson.
