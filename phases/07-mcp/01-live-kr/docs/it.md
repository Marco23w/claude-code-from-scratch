# MCP: un KR vivo da una fonte vera

> MCP e' la presa. Una volta che uno strumento e' collegato, "quanti account la settimana scorsa?" smette di essere un export e diventa una domanda :)

**Badge:** 🔌 Plugged In  ·  **Tempo:** ~2 h 30  ·  **Prerequisiti:** fase 06

## Cosa saprai fare
- Spiegare cos'e' un server MCP e dove si configura (`.mcp.json`, scope, connettori).
- Collegare una fonte del tuo canale a Claude Code, in sola lettura.
- Mettere un numero vivo in STATUS.md con la fonte scritta come `mcp:<server>` e una data as-of.

## Il problema
La fase 03 partiva da un CSV esportato a mano. Va bene una volta. Ma il report del lunedi' vuole
il numero ogni settimana, il tuo STATUS lo vuole fresco, e il tuo agente analista vuole
controllarlo. Gli export non scalano, e perdono il filtro che hai usato.

MCP (Model Context Protocol) e' il modo in cui Claude parla con gli strumenti: Mixpanel,
Supabase, Slack, Notion, Adjust, Meta Ads, Google Drive. Ognuno e' un "server" che espone poche
funzioni. Lo colleghi e Claude puo' chiamare "esegui questa query" o "leggi questo canale" come
un tool, con gli stessi permessi si'/no di tutto il resto.

## Il concetto
```
Claude Code  --MCP-->  server (mixpanel)   --API-->  Mixpanel
             --MCP-->  server (supabase)   --SQL-->  il tuo database
             --MCP-->  connettore claude.ai --OAuth-->  Slack, Drive, Notion, Gmail
```
Dove si configura:
- `.mcp.json` nel workspace (scope progetto, condiviso con chi clona): server locali come un
  database o un browser.
- `claude mcp add <nome> ...` (scope utente): tuoi, in ogni cartella.
- Connettori claude.ai: quelli che autorizzi nel browser (Slack, Notion, Drive); compaiono come
  `mcp__claude_ai_<Nome>__<tool>`.

I segreti non vanno mai in `.mcp.json`. Usa `${MIXPANEL_SECRET}` e imposta la variabile nella
tua shell. Un token in un file in un repo git e' un token su internet.

Postura: prima sola lettura. Leggi un KR; non scrivi su Mixpanel, non posti su Slack. Le
scritture arrivano dopo, una alla volta, ognuna con un via esplicito. E' il modo Finanz, riga 2.

## Costruiscilo
### Passo 1: scegli la fonte
Il numero principale del tuo canale vive da qualche parte: Mixpanel (account, funnel),
Supabase/Engine (spesa, creative), Adjust (install), Meta Ads (spesa). Scegli quella che tiene il
tuo primo KR della fase 02. Chiedi al tutor quale MCP e' quello giusto e se hai gia' l'accesso
(alcuni li deve dare Marco: dillo nel check del lunedi' se sei bloccato).

### Passo 2: collegalo
Due strade. (a) Un connettore claude.ai: autorizzalo nel browser, riavvia `claude`, scrivi
`/mcp` e vedilo in lista. (b) Un server locale: aggiungilo a `.mcp.json` da
`outputs/mcp.template.json` con la variabile d'ambiente, mai il token; imposta la variabile nella
shell; riavvia; `/mcp`.

### Passo 3: fai la domanda
"Usando l'MCP <server>, quanti <tuo KR> nell'ultima settimana ISO, con la query esatta che hai
eseguito?" Claude chiama il tool (chiede: si'). Leggi il numero E la query. Se la query e'
sbagliata (evento sbagliato, finestra sbagliata), correggila adesso: questa query diventa la riga Source.

### Passo 4: dentro STATUS.md
Aggiorna la riga del KR: Actual = il numero, Status = MEASURED, Source = `mcp:<server>` piu' la
query in poche parole, As of = oggi. Ora anche `last-updated` e' oggi.

### Passo 5: dimostra che e' vivo
Domani (o dopo il prossimo aggiornamento dei dati), fai la stessa domanda. Numero diverso, stessa
query. E' il momento in cui l'export muore.

## Usalo
Il report settimanale di Marco legge i funnel Mixpanel, le coorti Adjust, la spesa Meta e il
Supabase dell'Engine via MCP, tutto in sola lettura, e la sezione Sources del report elenca la
query di ogni cifra. Esistono anche le scritture su Meta o Slack, ma ognuna aspetta il suo via
esplicito, e un hook le blocca mentre girano i team di agenti.

## Cosa ti resta
Una fonte collegata e una riga di STATUS che si legge da sola.

## Check
`bin/check.sh 07` verifica: `.mcp.json` valido con almeno un server · nessuna stringa a forma di
token dentro · STATUS.md ha una riga con `mcp:` nella Source, etichettata MEASURED, con as-of
entro 7 giorni. Se hai usato solo un connettore claude.ai, crea comunque `.mcp.json` con il nome
di quel server come voce segnaposto: il file e' il registro di cio' da cui dipende il tuo OS.

## Termini chiave
| Termine | Cosa dice la gente | Cosa vuol dire davvero |
|---|---|---|
| MCP | "l'API" | Model Context Protocol: un modo standard per Claude di chiamare strumenti esterni come funzioni. |
| Server | "l'integrazione" | Un endpoint MCP che espone pochi tool (query, read, list). Locale o remoto. |
| Scope | "dove e' installato" | Progetto (`.mcp.json`, condiviso), utente (tuo ovunque), connettore (account claude.ai). |
| `${VAR}` | "un segnaposto" | Espansione di variabile d'ambiente: il segreto vive nella shell, non nel file. |
| Postura read-only | "stare attenti" | Solo tool di lettura finche' una scrittura non ha un via esplicito. |

## Per approfondire
- MCP in Claude Code: https://code.claude.com/docs/en/mcp (scope, `claude mcp add`, espansione env)
