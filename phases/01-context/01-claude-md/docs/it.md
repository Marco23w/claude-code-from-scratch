# CLAUDE.md: dillo una volta sola

> Tutto quello che continui a ripetere a Claude va in un file che lui legge prima che tu scriva. Lo scrivi una volta, te lo dimentichi per sempre :)

**Badge:** 🧠 Mind Reader  ·  **Tempo:** ~1 h 30  ·  **Prerequisiti:** fase 00

## Cosa saprai fare
- Dare a Claude istruzioni fisse per il tuo canale: chi sei, da dove vengono i numeri, cosa non deve mai fare da solo.
- Sapere i tre posti dove puo' vivere un CLAUDE.md e quale vince.
- Spezzare le regole in piu' file e importarle con `@`.

## Il problema
Ogni sessione parte vuota (l'hai visto con /clear). Quindi ogni volta rispieghi: "faccio TikTok
per Finanz, i numeri stanno in Adjust e nell'Engine, non mandare mai niente, scrivi in inglese..."
Dieci sessioni, dieci ripetizioni, e un giorno dimentichi la riga "non mandare mai". Quel giorno
e' un brutto giorno.

Un CLAUDE.md e' la soluzione: un file markdown nella cartella, letto in automatico a ogni avvio.
Quello globale di Marco e' 90 righe ed e' il motivo per cui il suo Claude risponde come il suo
Claude, non come un assistente qualsiasi.

## Il concetto
```
~/.claude/CLAUDE.md          tu, ovunque (ogni cartella)           <- "chi sono, come lavoro"
<workspace>/CLAUDE.md        questo progetto                        <- "questo canale, le fonti, le regole"
<workspace>/sub/CLAUDE.md    solo quando Claude lavora sotto sub/   <- "le specifiche di quest'angolo"
```
Si caricano tutti e tre, il piu' specifico per ultimo. E una riga tipo `@glossary.md` tira dentro
un altro file, cosi' il file principale resta corto.

La regola che conta: **una riga che non cambia il comportamento non ci sta.** "Sii utile" e'
rumore. "I numeri vengono da Adjust, coorte d7, mai dalla dashboard Meta" cambia il comportamento.

Cosa non ci va mai: ID, token, chiavi, dati personali di chiunque. E' un file di testo che viene copiato.

## Costruiscilo
### Passo 1: guardane uno vero
Nel repo del corso leggi `reference/finanz-way.md` (una pagina). Sono le regole di casa di Marco.
Scegli le tre che contano di piu' per il tuo canale. Le metterai nel tuo.

### Passo 2: scrivi il tuo CLAUDE.md
Nel tuo workspace chiedi a Claude: "crea CLAUDE.md con queste sezioni: `## Chi` (io, il mio
canale, i miei mercati), `## Da dove vengono i numeri` (una riga per fonte: strumento, cosa
misura, chi lo possiede), `## Fermati e chiedi` (la lista delle cose che non fai mai senza il mio
via esplicito)". Riempilo con contenuto vero. Righe corte. Esempio di una buona riga di "Fermati
e chiedi": "mandare qualsiasi cosa su Slack a nome mio". Una cattiva: "stare attento".

### Passo 3: importa un glossario
Crea `glossary.md` con 5 termini del tuo canale (cosa vuol dire "ASR" per te, cosa vuol dire
"install", la finestra di coorte che usi...). Aggiungi una riga `@glossary.md` in cima a
CLAUDE.md. Ora chiedi a Claude "cosa vuol dire ASR qui?" in una sessione nuova (`/clear` poi
chiedi). Lo sa. Mind reader.

### Passo 4: testa il comportamento, non il file
`/clear`. Chiedi a Claude di "postare il numero della settimana su Slack". Deve fermarsi e
chiedere, perche' il tuo "Fermati e chiedi" lo dice. Se non lo fa, la riga non e' abbastanza
chiara. Riscrivila finche' non si ferma.

### Passo 5: pota
Rileggi il tuo CLAUDE.md. Cancella ogni riga che non cambierebbe quello che Claude fa.
Piu' corto e' piu' forte.

## Usalo
Il workspace di Marco ha 56 file CLAUDE.md: uno globale, uno per progetto, uno per paese dentro
Meta Ads e ASO. Quello globale ha una sezione "Stop and ask before" con quattro righe, e una
sezione "Learned rules" che cresce ogni volta che Claude sbaglia qualcosa. Il tuo parte con tre
sezioni. Crescera' allo stesso modo.

## Cosa ti resta
`CLAUDE.md` + `glossary.md` nel tuo workspace. Da ora ogni tua sessione parte informata.

## Check
`bin/check.sh 01` verifica: CLAUDE.md esiste · ha `## Chi`, `## Da dove vengono i numeri`,
`## Fermati e chiedi` (o le versioni inglesi) · importa un file esistente con `@` · non contiene
niente a forma di token.

## Termini chiave
| Termine | Cosa dice la gente | Cosa vuol dire davvero |
|---|---|---|
| CLAUDE.md | "il system prompt" | Istruzioni fisse, caricate all'avvio, gerarchiche (globale > progetto > sottocartella). |
| @import | "un link" | Una riga `@percorso` che incolla un altro file dentro CLAUDE.md al caricamento. |
| /memory | "la memoria di Claude" | Il comando che apre i CLAUDE.md in gioco. La memoria vera e' la fase 08. |
| /init | "il setup" | Genera un primo CLAUDE.md dalla cartella. Va bene per il codice, troppo generico per il growth. |

## Per approfondire
- Claude Code memory docs: https://code.claude.com/docs/en/memory (gerarchia, import, /memory)
