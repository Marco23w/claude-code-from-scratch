# Il modo Finanz: numeri con la fonte

> Un numero senza fonte e' un pettegolezzo. Etichettalo, dagli una fonte, o scrivi "no data". Non c'e' una terza via :)

**Badge:** 🔎 Source Hunter  ·  **Tempo:** ~1 h 30  ·  **Prerequisiti:** fase 01

## Cosa saprai fare
- Etichettare ogni cifra MEASURED, DERIVED o ASSUMED, e dire dove l'hai letta.
- Scrivere uno STATUS.md per il tuo canale: target vs actual, owner, prossima azione, intestazione leggibile da uno script.
- Far rifiutare a Claude di inventare un numero.

## Il problema
Claude parla bene. Chiedi "com'e' andato TikTok questa settimana?" e ti da' un paragrafo sicuro
con dentro dei numeri. Alcuni letti da un file, alcuni calcolati, alcuni... plausibili. A valle
nessuno sa quale e' quale, e una cifra plausibile in un report settimanale diventa una decisione
il lunedi'.

La regola di Marco, parola per parola dal suo CLAUDE.md: "Ogni numero, metrica, ID, nome,
citazione o attribuzione che entra in un report, una decisione o una scrittura deve avere una
fonte che Marco puo' riaprire." Questa fase e' quella regola, fatta file.

## Il concetto
Tre etichette, sempre visibili:
```
MEASURED   letto da una fonte   -> "12,4% install->account, funnel Mixpanel X, W41"
DERIVED    calcolato da input misurati -> "CPU 0,74 EUR = spesa (Meta) / account (Mixpanel)"
ASSUMED    ne' l'uno ne' l'altro -> "3h per fase (ASSUMED, da tarare sui piloti)"
no data    il quarto onesto     -> e cosa serve per averlo
```
E un file per progetto che tiene lo stato, `STATUS.md`:
```
---
last-updated: 2026-10-14     <- leggibile da uno script: ti avvisa quando e' vecchio
review-interval: 7d
owner: <tu>
---
## Target vs actual   <- una tabella: KR | Target | Actual | Etichetta | Fonte | Al giorno
## Prossima azione    <- una riga, owner, data
```
Ogni progetto nel workspace di Marco ne ha uno. Una skill cockpit li legge tutti in un colpo.

## Costruiscilo
### Passo 1: scegli tre KR
Del tuo canale, questo trimestre. Veri. Se non hai un target, scrivi il target che difenderesti
ed etichettalo ASSUMED. Si puo'. Inventare un actual, no.

### Passo 2: caccia agli actual
Per ogni KR, trova il numero dove vive (Adjust, Mixpanel, l'Engine, un foglio). Scrivi il posto
esatto: strumento, nome del report, filtro, data. Se oggi non arrivi alla fonte: "no data", piu'
cosa serve ("serve accesso Mixpanel al funnel X").

### Passo 3: scrivi STATUS.md
Chiedi a Claude: "crea STATUS.md da reference/STATUS_template.md con i miei tre KR". Dagli i
numeri E le fonti. Poi leggi ogni riga: ogni Actual ha MEASURED / DERIVED / ASSUMED o "no data"?
Ogni Fonte permette a un collega di riaprirla?

### Passo 4: prova a romperlo
Chiedi a Claude: "aggiungi il tasso install-to-account della settimana scorsa" senza dare una
fonte. La risposta giusta e' una domanda di ritorno, o "no data". Se Claude scrive un numero, il
tuo CLAUDE.md della fase 01 ha bisogno di una riga in piu' sotto "Da dove vengono i numeri".
Aggiungila. Riprova.

### Passo 5: datalo
`last-updated` e' oggi, `review-interval` e' 7d. Nella fase 08 un hook ti rompera' quando e' vecchio.

## Usalo
Lo STATUS.md di Meta Ads di Marco ha una riga KR che dice: "Testing restock | 2 creative nuove a
settimana per lingua | no data (coda vuota il 2026-09-10) | `paid_ads_creative_queue` |
2026-09-10". No data, con la fonte e la data. Quella riga e' piu' utile di un "on track" inventato.

## Cosa ti resta
`STATUS.md` nel tuo workspace. Da ora ogni esercizio lo aggiorna, e il capstone viene giudicato su quello.

## Check
`bin/check.sh 02` verifica: STATUS.md esiste · `last-updated:` data ISO · `review-interval: Nd` ·
tabella KR con colonna Source · almeno 3 righe · ogni riga con MEASURED / DERIVED / ASSUMED o "no data".

## Termini chiave
| Termine | Cosa dice la gente | Cosa vuol dire davvero |
|---|---|---|
| MEASURED | "il numero vero" | Letto da una fonte con un nome a un'ora con un nome. Niente altro vale. |
| DERIVED | "calcolato" | Calcolato da input MEASURED con una formula che puoi mostrare. |
| ASSUMED | "una stima" | Ne' l'uno ne' l'altro. Si puo', basta che lo dica. |
| no data | "non lo sappiamo" | La cella onesta. Sempre seguita da cosa serve per riempirla. |
| Definizione canonica | "la metrica" | L'unica formula concordata (es. CPU = spesa paid / account nuovi). Cambiarla in silenzio rompe ogni report. |

## Per approfondire
- `reference/finanz-way.md` in questo repo: le dieci regole di casa, una pagina.
