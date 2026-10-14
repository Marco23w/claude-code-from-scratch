# Hello Claude: your first session

> Claude Code is a terminal that talks back. You type, it reads your files, edits them, runs commands. With your yes. That's it :)

**Badge:** 🐣 Hello Claude  ·  **Time:** ~45 min  ·  **Prerequisites:** none

## What you'll be able to do
- Open Claude Code in a folder and know what it can see.
- Say yes (or no) to what it wants to do, and understand why it asks.
- Make it create your first file, then find it with your own eyes.

## The Problem
You have used Claude in the browser. You paste, it answers, you copy. Then you paste the answer
into a doc, a sheet, a Slack message. The work is on your side of the glass.

Claude Code moves Claude to your side: into the folder where your reports, your CSVs, your notes
live. It can read them, write them, run things. Which is great, and a bit scary. So the first
thing to learn is not "how to prompt". It's: what does it see, what can it touch, when does it ask.

## The Concept
```
   you  --prompt-->  Claude Code  --reads-->  files in this folder (and below)
                          |
                          +--wants to-->  edit a file / run a command
                          |                     |
                          +<-- asks you: allow? (once / always / no)
                          |
                          +--does it-->  shows you what changed
```
Three ideas:
1. **The folder is the world.** Claude sees the folder you started it in. Not your whole Mac.
2. **Tools need a yes.** Reading is free. Editing and running commands ask first. "Always allow"
   is a promise you make for this folder only.
3. **Context is what it has read so far.** Files, your messages, its own answers. New session =
   empty context, except `CLAUDE.md` (phase 01, spoiler).

## Build It
### Step 1: open it
In Terminal: `cd ~/Finanz/growth-os` (your workspace, created by setup) then `claude`.
You see a prompt. Type `/help` -> a list of commands. Type `/status` -> which model, which
folder. That folder line is the "world" from the concept above.

### Step 2: ask it something harmless
Type: "what files are in this folder?" -> it runs a listing and tells you. No permission asked:
reading is free.

### Step 3: make it write
Type (in your words): "create work/hello.md with my GitHub handle <handle>, today's date in
YYYY-MM-DD format, and my growth channel <channel>, as a tiny note to my future self".
It will ask to create the file -> say yes. Then open the file yourself: `cat work/hello.md`.
Read it. That's the first thing Claude wrote on your machine :)

### Step 4: change your mind
Ask: "add a line: 'first badge loading...'". It asks again? Then the yes from before was "once".
Try "always allow for this session" and notice it stops asking for that tool.

### Step 5: clear and see what's lost
Type `/clear`. Ask: "what did we just write?" -> it doesn't know. New context. That memory
problem is exactly what phase 01 fixes.

## Use It
Marco runs Claude Code in a folder with 26 projects, 23 skills and 31 agents. The first thing it
does in every session is read the folder's rules, not wait for a prompt. By phase 08 you'll see
how. For now: he still says yes or no to every write outside his allowlist. The yes/no is the job.

## Ship It
`work/hello.md`: your first artifact. Small, but real. The check reads it.

## Check
`bin/check.sh 00` verifies: the file exists · it contains your handle · an ISO date · your channel.

## Key Terms
| Term | What people say | What it actually means |
|---|---|---|
| Context | "Claude's memory" | What it has read in this session. Gone at /clear. |
| Permission | "it's asking again, annoying" | A safety stop before a write or a command. Allowlists make it quiet. |
| Session | "the chat" | One run of `claude` in one folder. Hooks log its start and end (that's the course tracking). |

## Further Reading
- Claude Code quickstart: https://code.claude.com/docs/en/quickstart (10 minutes, the official tour)
