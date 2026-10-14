# Memoria e cadenze: un OS che sopravvive alla settimana

> Un sistema che devi ricordarti di far girare non e' un sistema. Memoria, cadenze e plugin sono quello che lo fa girare da solo :)

**Badge:** 🧬 Never Forgets  ·  **Tempo:** ~2 h  ·  **Prerequisiti:** fase 07

## Cosa saprai fare
- Tenere quello che Claude impara sul tuo canale tra una sessione e l'altra, in una cartella memoria con un indice.
- Registrare i lavori ricorrenti in un file e lasciare che un hook ti avvisi quando scadono.
- Installare un plugin (un pacchetto di skill) da un marketplace e sapere cosa aggiunge.

## Il problema
Dopo sette fasi hai un CLAUDE.md, uno STATUS, una skill, due hook, un agente, una fonte viva. Poi
vai in ferie una settimana. Torni: lo STATUS e' vecchio, il weekly non e' partito, e Claude ha
dimenticato le tre cose che avevi deciso giovedi' perche' stavano in una sessione, non in un file.

Tre rimedi. Memoria: una cartella di appunti piccoli che Claude legge tramite un indice, cosi' le
decisioni sopravvivono. Cadenze: un JSON di lavori con un giorno di scadenza, e l'hook della fase
05 che ti rompe una volta per periodo. Plugin: skill scritte da qualcun altro (Marco, per
esempio) che installi invece di riscrivere.

## Il concetto
```
memory/
├── MEMORY.md                 l'indice: una riga per appunto, caricato all'avvio
├── decision_angles_w42.md    un fatto per file, con frontmatter (name, description, type)
└── feedback_no_tags_oct13.md

.claude/cadences.json         [{id, type: weekly|monthly, due_dow|due_dom, message}]
.claude/hooks/cadence-reminder.sh   UserPromptSubmit: una volta per periodo, sentinella in .claude/state/

~/.claude/plugins/            dove /plugin marketplace add + /plugin install mettono le cose
```
Regole della memoria: un fatto per file; MEMORY.md e' un indice, mai il contenuto; frontmatter
cosi' uno script li puo' elencare; collega gli appunti con `[[nome]]`. La cartella di Marco ha
1.032 appunti e un indice di 241 righe; la tua parte con uno.

Cadenze: il file e' la lista, l'hook e' la sveglia. `type: weekly, due_dow: 1` vuol dire "da
lunedi' in poi, finche' non e' fatto". Il file sentinella (`.claude/state/cadence-<id>-<settimana>`)
e' quello che lo fa scattare una volta sola. Il `cadences.json` di Marco ha 10 voci; il report del
lunedi' e' una di queste.

Plugin: un marketplace e' un repo git con un `.claude-plugin/marketplace.json`; un plugin e' una
cartella con skill, agenti, hook. `head-of-growth` e' quello di Marco: 14 skill growth (report
settimanale, report paese, copy ASO, audit Meta).

Worktree, una riga: `claude --worktree <nome>` da' a Claude una copia separata della cartella per
lavorare in parallelo senza toccare la tua. Non oggi, ma esiste.

## Costruiscilo
### Passo 1: la tua prima memoria
Crea `memory/MEMORY.md` con l'intestazione "# Memory index" e una riga che linka
`memory/decision_<qualcosa>.md`: la decisione che hai preso nella fase 07 (quale fonte, quale
query, perche'). Scrivi quell'appunto con frontmatter (name, description, type: project) e una
riga "Why:" e "How to apply:". Aggiungi `@memory/MEMORY.md` al tuo CLAUDE.md. `/clear`, chiedi
"che fonte usiamo per <KR>?". Lo sa, dall'appunto.

### Passo 2: cadenze
Copia `outputs/cadences.template.json` in `.claude/cadences.json` e mettici un lavoro settimanale
vero (il recap settimanale, due_dow 1). Copia `outputs/cadence-reminder.sh` in `.claude/hooks/`,
rendilo eseguibile, cablalo in settings.json come hook UserPromptSubmit (l'hai fatto nella fase
05). Riavvia, scrivi qualsiasi cosa: nel giorno di scadenza vedi `<cadence-reminder>` con il tuo
lavoro. Scrivi di nuovo: silenzio. Sentinella.

### Passo 3: installa il plugin di Marco
In `claude`: `/plugin marketplace add` con il percorso o l'URL che il tutor ti da' per il
marketplace head-of-growth, poi `/plugin install head-of-growth`. Lancia
`/weekly-experiments-report` una volta e guarda com'e' fatta una skill matura. Poi guarda
`~/.claude/plugins/`: e' li' che vive.

### Passo 4: controllo di vecchiaia
Metti `last-updated` in STATUS.md a una data di 10 giorni fa. Aggiungi al tuo hook delle cadenze
il blocco di staleness da `reference/examples/hooks/cadence-reminder.sh` (la seconda meta' del
file). Riavvia, scrivi: uno `<staleness-alert>` dice che STATUS ha 10 giorni. Sistema la data.
Quell'avviso e' quello su cui gira tutto il workspace di Marco.

## Usalo
La sessione di Marco parte con: l'indice della memoria (1.032 appunti), le cadenze in scadenza
in questo periodo, gli impegni che scadono tra due giorni, i thread Slack in attesa. Niente di
tutto questo e' scritto a mano. Tutto viene dai tre meccanismi che hai appena costruito, in scala.

## Cosa ti resta
`memory/` con un indice, `cadences.json` con un lavoro settimanale e il suo hook, un plugin
installato. Il tuo OS ora sopravvive alla tua attenzione.

## Check
`bin/check.sh 08` verifica: `.claude/cadences.json` valido con una voce weekly · un hook
`*cadence*` eseguibile · `memory/MEMORY.md` linka un appunto esistente · il plugin head-of-growth
e' installato sotto `~/.claude/plugins/`.

## Termini chiave
| Termine | Cosa dice la gente | Cosa vuol dire davvero |
|---|---|---|
| Memoria | "Claude si ricorda" | File che tu (o Claude) scrivete, indicizzati da MEMORY.md, caricati via CLAUDE.md. Niente di magico. |
| Cadenza | "un promemoria" | Un lavoro con un giorno di scadenza in cadences.json, fatto scattare una volta per periodo da un hook con sentinella. |
| Plugin | "un'app" | Una cartella di skill/agenti/hook installata da un repo marketplace. |
| Marketplace | "uno store" | Un repo git con `.claude-plugin/marketplace.json` che elenca i plugin. Puo' essere locale o privato. |
| Worktree | "un branch" | Una copia di lavoro separata cosi' Claude lavora in parallelo senza toccare i tuoi file. |

## Per approfondire
- Memoria: https://code.claude.com/docs/en/memory · Plugin: https://code.claude.com/docs/en/plugins
