# Capstone: il tuo Growth OS

> Tutto quello che hai costruito, messo insieme e usato per una settimana vera. Non una demo: il tuo canale, i tuoi numeri, il tuo lunedi' :)

**Badge:** 🏆 Growth OS Owner + 🎓 certificato  ·  **Tempo:** ~8 h in una settimana  ·  **Prerequisiti:** fase 08

## Cosa saprai fare
- Far girare il tuo canale per una settimana sul tuo sistema: CLAUDE.md, STATUS, 2 skill, 1 agente, 1 hook, 1 MCP.
- Mostrarlo a Marco in 15 minuti e difendere tre domande senza appunti.
- Passare lo stesso sistema a un collega che clona il tuo repo.

## Il problema
Otto fasi di pezzi. I pezzi non sono un sistema finche' non girano insieme su lavoro vero, con la
pressione del tempo vera, per giorni di fila. Il capstone e' quella settimana. Qualcosa si
rompera': un hook che scatta troppo spesso, una skill che legge il file sbagliato, una fonte che
vuole un token che non hai. Sistemare quelle cose e' il corso.

## Il concetto
La griglia di review (`reference/capstone-rubric.md`), in breve:
```
 deve                                                     provato da
 CLAUDE.md   chi, fonti, fermati-e-chiedi, niente segreti   file
 STATUS.md   3 KR, etichettati, con fonte, aggiornato        file + git log
 2 skill     girano e producono il loro output               lanciarle dal vivo
 1 agente    sola lettura, Verdict + Weakest assumption      lanciarlo dal vivo
 1 hook      scatta sul suo evento, utile, non blocca mai    mostrarlo scattare
 1 MCP       un KR vivo, fonte mcp:, as-of < 7 giorni        riga di STATUS
 la settimana  commit in 4+ giorni distinti                  git log
 la demo     15 min con Marco, 3 domande, niente appunti     decide Marco
```
Pass = tutti i "deve". Marco registra `passed` o `redo` (con una riga di perche') dalla sua
skill del lunedi'. `passed` trasforma il tuo certificato da "pending" a firmato.

## Costruiscilo
### Passo 1: assembla (giorno 1)
Fai del workspace un repo git che pushi: `gh repo create <handle>/growth-os-<canale> --private
--source . --push` (privato: dentro ci sono i tuoi KR). Controlla che i sette artefatti ci siano:
`bin/check.sh 09` dal repo del corso ti dice cosa manca, tranne la settimana stessa.

### Passo 2: fai girare la settimana (giorni da 1 a 5)
Ogni giorno lavorativo: apri `claude` nel workspace, fai una cosa vera per il tuo canale
attraverso l'OS (il weekly il lunedi', un controllo di un numero, un verdetto dell'analista su
una decisione, un aggiornamento dello STATUS). Committa a fine giornata:
`git add -A && git commit -m "day n: <cosa>"`. Quattro commit in quattro giorni diversi e' il minimo.

### Passo 3: rompi e sistema (quando succede)
Qualcosa fara' i capricci. Scrivi cosa si e' rotto e cosa hai cambiato in `memory/` come un
appunto ciascuno (fase 08). Quegli appunti sono la parte piu' preziosa della review: provano che
capisci il sistema, non solo la ricetta.

### Passo 4: la decisione (almeno una)
Prendi una decisione vera su un numero uscito dall'OS (un KR dall'MCP, un verdetto dell'agente).
Scrivila in STATUS sotto "This week" con la fonte. "Abbiamo tenuto l'angolo X perche' CR W42 =
10,6% (mcp:mixpanel, funnel Y) contro 8,1% di baseline" e' la frase che Marco vuole leggere.

### Passo 5: demo e done (giorno 5 o il lunedi' dopo)
Lancia `bin/check.sh 09` finche' non passa. `bin/done.sh 09` segna il capstone in attesa di
review e scrive il certificato come pending. Prenota 15 minuti con Marco: passa in rassegna i
sette pezzi, mostra l'hook che scatta e l'agente che gira, rispondi alle sue tre domande. Lui
cambia lo stato.

## Usalo
Il workspace di Marco e' nato cosi': una cartella, uno STATUS, una skill, cinque mesi fa. Il tuo e'
la stessa cosa alla settimana uno. Tutto quello che viene dopo e' aggiungere un componente alla
volta, ognuno con un check, ognuno con una fonte.

## Cosa ti resta
`<handle>/growth-os-<canale>`: un repo che un collega puo' clonare e far girare. E un certificato :)

## Check
`bin/check.sh 09` verifica: CLAUDE.md · STATUS.md aggiornato entro 7 giorni · 2 skill · 1 agente ·
1 hook cablato · 1 server MCP · commit in 4+ giorni distinti nell'ultima settimana. La demo e' di Marco.

## Termini chiave
| Termine | Cosa dice la gente | Cosa vuol dire davvero |
|---|---|---|
| Growth OS | "il mio setup" | La cartella che fa girare il tuo canale: contesto, stato, skill, agenti, hook, fonti. |
| Capstone review | "l'esame" | 15 minuti, sette pezzi dal vivo, tre domande. Pass o redo con un motivo. |
| Certificato | "un badge" | `progress/<handle>.certificate.md`, firmato quando Marco mette la review a passed. |

## Per approfondire
- I tuoi appunti in `memory/` della settimana. Sul serio: rileggili prima della demo.
