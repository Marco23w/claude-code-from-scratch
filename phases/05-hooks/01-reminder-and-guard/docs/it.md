# Hook: l'harness ti rompe al posto tuo

> Un hook e' uno script minuscolo che Claude Code lancia su un evento. Niente prompt, niente memoria: succede e basta. Ogni volta :)

**Badge:** 🪝 Puppet Master  ·  **Tempo:** ~2 h 30  ·  **Prerequisiti:** fase 04

## Cosa saprai fare
- Dire quali eventi lancia Claude Code e scegliere quello giusto per un lavoro.
- Scrivere un hook che inietta contesto a ogni prompt (una scadenza, uno stato) senza che tu lo scriva.
- Scrivere una guardia che blocca un comando pericoloso prima che giri, con exit code 2.
- Sapere come il corso stesso ti traccia: con tre di questi.

## Il problema
La fase 01 ha dato a Claude istruzioni fisse. Ma le istruzioni sono passive: Claude le legge, poi
devi comunque ricordarti il report del venerdi', lo STATUS vecchio, la cosa che hai promesso. E
una regola come "mai cancellare ricorsivamente" e' un desiderio finche' qualcosa non la fa rispettare.

Gli hook sono il far rispettare. Girano fuori dal modello: uno script shell, lanciato da un
evento, che stampa contesto, scrive un file, o dice no. Il workspace di Marco ne ha 17. I
promemoria che vedi nelle sue sessioni (cadenze, impegni in scadenza, Slack in sospeso) non sono
Claude che fa il furbo. Sono hook.

## Il concetto
```
 evento                quando                              a cosa serve di solito
 SessionStart          claude si apre                      aggiornare una cache, stampare "dove siamo"
 UserPromptSubmit      premi invio                         iniettare contesto: scadenze, promemoria
 PreToolUse            prima che un tool giri              guardia: blocca o permetti (exit 2 = blocca)
 PostToolUse           dopo che un tool e' girato          lint, formattazione, log
 Stop                  Claude ha finito un turno           heartbeat, salvare un riassunto
 SessionEnd            claude si chiude                    pulizia, sync, push
```
Ogni hook riceve JSON su stdin (id sessione, il prompt, il tool e il suo input). Quello che
stampa su stdout diventa contesto per Claude (su UserPromptSubmit e SessionStart). Exit 0 =
tutto bene. Exit 2 = blocca, e stderr e' il motivo mostrato a Claude. Qualsiasi altro = errore
che non blocca.

Il cablaggio, in `.claude/settings.json` del workspace:
```json
{ "hooks": {
    "UserPromptSubmit": [ { "hooks": [ { "type": "command",
        "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/deadline-reminder.sh", "timeout": 5 } ] } ],
    "PreToolUse": [ { "matcher": "Bash", "hooks": [ { "type": "command",
        "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/rm-guard.sh", "timeout": 5 } ] } ]
} }
```
`matcher` filtra quale tool. `timeout` e' in secondi. `$CLAUDE_PROJECT_DIR` e' la cartella in cui
hai aperto Claude, cosi' il percorso funziona su qualsiasi macchina.

Due pattern da rubare. La sentinella: un hook che deve scattare una volta al giorno tocca un file
con la data di oggi nel nome e prima lo controlla. E l'heartbeat: un hook Stop che scrive un
timestamp, cosi' anche un terminale ucciso lascia una traccia. Il tracking del corso li usa
entrambi. Leggi `.claude/hooks/course-session-start.sh` nel repo del corso: sono 30 righe.

## Costruiscilo
### Passo 1: il promemoria
Nel tuo workspace crea `.claude/hooks/deadline-reminder.sh` da `outputs/deadline-reminder.sh`.
Mettici la tua scadenza vera (il report del venerdi', il weekly del lunedi'). `chmod +x`. Provalo
senza Claude: `printf '{"prompt":"hi"}' | .claude/hooks/deadline-reminder.sh`. Deve stampare il
tuo promemoria in un tag `<reminder>`. Rilancialo: niente, la sentinella dice che oggi e' fatto.

### Passo 2: la guardia
Crea `.claude/hooks/rm-guard.sh` da `outputs/rm-guard.sh`. Legge il JSON, estrae
`tool_input.command`, e se il comando e' una cancellazione ricorsiva (`rm -r...`) scrive un
motivo su stderr ed esce con 2. Prova:
`printf '{"tool_name":"Bash","tool_input":{"command":"rm -rf /tmp/x"}}' | .claude/hooks/rm-guard.sh; echo $?` -> 2.
Poi con `ls` -> 0.

### Passo 3: cabla entrambi
Chiedi a Claude: "aggiungi i due hook a .claude/settings.json come in outputs/settings.hooks.json".
Controlla che il JSON sia valido: `jq . .claude/settings.json`. Riavvia `claude` (gli hook si
caricano all'avvio).

### Passo 4: guardali dal vivo
Scrivi qualsiasi cosa: il tuo promemoria compare nel contesto di Claude (potrebbe citarlo). Chiedi
a Claude di "cancellare la cartella work ricorsivamente": la guardia lo blocca e Claude ti dice
perche'. E' la sensazione che vuoi: la regola tiene anche quando te la dimentichi.

### Passo 5: guarda il tuo stesso tracking
Nel repo del corso leggi `.claude/settings.json`. Tre hook: SessionStart, Stop, SessionEnd. Ora
sai esattamente cosa il corso registra di te, e avresti potuto scriverlo tu.

## Usalo
Il `cadence-reminder.sh` di Marco (copiato in `reference/examples/hooks/`) legge un `cadences.json`
con lavori settimanali, mensili e trimestrali, e fa scattare ciascuno una volta per periodo con
un file sentinella. Il suo `team-readonly-guard.py` e' un hook PreToolUse che blocca le scritture
su Meta Ads, Slack e Supabase ogni volta che gira un team di agenti. Una regola, fatta rispettare, per sempre.

## Cosa ti resta
Due hook nel tuo workspace: un promemoria che parla una volta al giorno e una guardia che non dorme mai.

## Check
`bin/check.sh 05` verifica: `settings.json` valido con `UserPromptSubmit` e `PreToolUse` ·
`*remind*.sh` e `*guard*.sh` eseguibili · il promemoria stampa su un prompt di prova · la guardia
esce con 2 su una cancellazione ricorsiva e con 0 su `ls`.

## Termini chiave
| Termine | Cosa dice la gente | Cosa vuol dire davvero |
|---|---|---|
| Hook | "un plugin" | Un comando shell legato a un evento, configurato in settings.json. Gira fuori dal modello. |
| Exit code 2 | "un errore" | Il codice che blocca. Exit 1 e' un errore che non blocca, quindi le guardie usano 2. |
| matcher | "un filtro" | Quale tool (PreToolUse/PostToolUse) o sorgente (SessionStart) riguarda l'hook. |
| Sentinella | "un lock file" | Un file vuoto la cui esistenza vuol dire "gia' fatto in questo periodo". |
| CronCreate | "uno scheduler" | Prompt programmati dentro la sessione. Per orari veri usa un hook Stop/SessionStart o launchd. |

## Per approfondire
- Riferimento hook: https://code.claude.com/docs/en/hooks (eventi, campi stdin, exit code, matcher)
