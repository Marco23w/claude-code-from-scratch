# Claude Code from Scratch 🐣 -> 🏆

Da "cos'e' questo terminale" a far girare il tuo canale sul tuo Growth OS. Dieci fasi, dieci
badge, un certificato. Fatto per il team growth di Finanz, da growth. Lo insegna Claude stesso,
dentro Claude Code :)

English version: [README.md](README.md)

## Come funziona
1. Cloni questo repo e apri Claude Code dentro.
2. `/start-learning` -> 3 domande, setup, un mini quiz di piazzamento. 5 minuti.
3. `/learn` -> una fase per sessione. Claude spiega, tu costruisci nel tuo workspace, uno script
   controlla il lavoro, rispondi a 4 domande, sblocchi un badge. Ripeti.
4. La fase 09 e' il capstone: il tuo Growth OS, usato per una settimana vera. Marco lo rivede e
   firma il certificato.

Ogni fase ti lascia qualcosa che tieni: un CLAUDE.md, uno STATUS.md, una skill, un hook, un
agente... Alla fine hai lo stesso tipo di sistema che usa Marco, alla tua scala.

## Le dieci fasi

| Fase | Badge | Costruisci | ~Tempo |
|---|---|---|---|
| 00 Prima sessione | 🐣 Hello Claude | il tuo primo file, scritto da Claude | 1 h |
| 01 Contesto | 🧠 Mind Reader | un CLAUDE.md per il tuo canale | 2 h |
| 02 Il modo Finanz | 🔎 Source Hunter | uno STATUS.md con KR con fonte | 2 h |
| 03 Strumenti e sessioni | 🛠️ Toolsmith | un report da un CSV, piu' un giro headless | 2 h |
| 04 Skill | ⚡ One-Command Wonder | il tuo recap settimanale come comando | 3 h |
| 05 Hook | 🪝 Puppet Master | un hook promemoria e una guardia di sicurezza | 3 h |
| 06 Agenti | 🤖 Team Builder | un agente analista in sola lettura | 3 h |
| 07 MCP | 🔌 Plugged In | un KR vero letto da una fonte vera | 3 h |
| 08 Memoria e cadenze | 🧬 Never Forgets | memoria, cadenze, un plugin | 2 h |
| 09 Capstone | 🏆 Growth OS Owner | il tuo Growth OS, una settimana vera | 8 h |

Le ore sono stime (ASSUMED) e verranno corrette dopo i primi allievi.
XP: 100 per fase, +50 per un quiz perfetto. Livelli: Rookie -> Operator -> Builder -> Architect -> Growth OS Owner.

## Prima di partire (10 minuti, una volta sola)
- Un Mac con Homebrew.
- Claude Code installato e loggato con il tuo seat Finanz: `npm install -g @anthropic-ai/claude-code`, poi `claude`.
- GitHub: membro dell'org Finanz, e `gh` loggato: `brew install gh jq && gh auth login`.
- Clona: `git clone https://github.com/Marco23w/claude-code-from-scratch.git && cd claude-code-from-scratch && claude`, poi `/start-learning`.

Quando Claude Code chiede se fidarsi degli hook di questa cartella, di' si': sono i quattro
script piccoli in `.claude/hooks/`, e puoi leggerli.

## Cosa viene tracciato, e cosa no
Il corso registra, sul tuo branch `learner/<tuo-handle>` in un repo **privato**
(`claude-code-from-scratch-progress`, lo vedete solo tu e Marco): quando una sessione inizia e finisce,
quali fasi hai passato, esiti dei check, punteggi dei quiz, minuti, e i feedback che mandi con `/feedback`.
Mai i tuoi prompt, le trascrizioni o i tuoi file. Marco lo legge ogni lunedi' per vedere a chi serve una mano.
Dettagli: `progress/SCHEMA.md`.

## Comandi
`/start-learning` · `/learn` · `/check-understanding NN` · `/course-guide` · `/done NN` · `/progress` · `/feedback`

## Crediti
Struttura ispirata a [AI Engineering from Scratch](https://aiengineeringfromscratch.com)
(Rohit Ghumare, MIT): fasi, battute della lezione, skill tutor, ogni lezione lascia qualcosa.
Contenuti e tono: Marco Amico, Head of Growth, Finanz.
