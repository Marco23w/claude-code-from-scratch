# Agenti: un analista in sola lettura

> Un agente e' un Claude a cui dai un brief una volta, una lista corta di tool, e che mandi a fare un lavoro solo. Dagli meno mani di quante ne hai tu, e diventa affidabile :)

**Badge:** 🤖 Team Builder  ·  **Tempo:** ~2 h 30  ·  **Prerequisiti:** fase 05

## Cosa saprai fare
- Scrivere il file di un agente: name, description, tools, model, e il brief.
- Lanciarlo da una sessione e ricevere un verdetto, senza che tocchi i tuoi file.
- Pensare come la tesi di Marco: obiettivo -> compiti -> un componente per compito -> uno che controlla i passaggi.

## Il problema
Il tuo report settimanale e' fatto (fase 04). Ora qualcuno deve leggerlo con occhio critico:
qual e' il numero piu' debole, qual e' l'assunzione che farebbe crollare il piano, cosa
chiederebbe uno scettico lunedi'. Se lo chiedi allo stesso Claude che l'ha scritto, sara'
gentile con il proprio lavoro. Se lo chiedi a un collega, aspetti un giorno.

Un agente e' un Claude separato con il suo brief e la sua lista di tool, piu' piccola. Gli dai
Read, Grep, Glob e nient'altro: puo' guardare, non puo' toccare. Legge il report, scrive il suo
verdetto come messaggio finale, e decidi tu. Marco ne ha 31, in tre team.

## Il concetto
```
.claude/agents/tiktok-analyst.md
---
name: tiktok-analyst
description: Fa il red team del report TikTok settimanale. Usalo dopo /tiktok-weekly, o quando dico "challenge this".
tools: Read, Grep, Glob          <- le mani. Niente Write, Edit, Bash: non puo' cambiare niente.
model: sonnet                    <- economico e veloce per leggere; opus per il ragionamento pesante.
---
Sei lo scettico... (il brief: cosa leggere, cosa produrre, in che ordine)
```
Come gira: nella tua sessione dici "usa l'agente tiktok-analyst su reports/weekly-W42.md".
Claude lo lancia come subagente (il tool Agent), lavora nel suo contesto, e torna solo il suo
messaggio finale. Il tuo contesto resta pulito. E' questo il punto: un lavoro, un componente,
niente che trabocca.

La cornice della tesi (reference/thesis-4-3-excerpt.md): parti dall'obiettivo, scomponilo in
compiti, dai a ogni compito il suo componente, e aggiungi un componente il cui unico lavoro e'
controllare i passaggi. L'analista e' il controllore del tuo weekly. Un team e' un insieme di
questi, ciascuno con tool chiusi, piu' uno che decide. Il meta-team di Marco: nove ruoli in sola
lettura, uno stratega, e un hook che blocca le scritture mentre girano.

## Costruiscilo
### Passo 1: leggine uno vero
`reference/examples/agents/growth-challenger.md` nel repo del corso. Nota: i tool sono tre, il
brief dice "prima il verdetto", e l'output e' il messaggio finale, niente di scritto.

### Passo 2: scrivi il tuo analista
Nel tuo workspace chiedi a Claude: "crea .claude/agents/<canale>-analyst.md con name
<canale>-analyst, tools Read, Grep, Glob, model sonnet, e questo brief: leggi l'ultimo
reports/weekly-W*.md e STATUS.md; produci `## Verdict` (una riga: forte, o ci si accontenta),
`## Weakest assumption` (il numero o la convinzione che, se sbagliata, rompe la settimana),
`## Three questions a sceptic would ask`; mai scrivere file; ogni affermazione punta a una riga
del report". Apri il file. Controlla la riga tools con i tuoi occhi.

### Passo 3: lancialo
`/clear` (gli agenti si caricano all'avvio, quindi riavvia `claude` se dice che non lo trova).
Di': "usa l'agente <canale>-analyst sul report di questa settimana". Guarda: Claude dice che sta
lanciando un agente, aspetta, e torna con un verdetto. Chiedi a Claude di salvare quel verdetto
come `reports/analyst-verdict.md` (l'agente non puo' scrivere; la sessione principale si').

### Passo 4: prova a farlo sgarrare
Chiedi: "usa l'analista per correggere il refuso in STATUS.md". Deve dire che non puo': niente
tool Edit. Se in qualche modo modifica, la tua riga tools e' sbagliata. Quel rifiuto e' la funzione.

### Passo 5: la domanda del team
Scrivi tre righe in fondo al verdetto: se questo fosse un team, quali sarebbero gli altri due
ruoli (uno legge i dati grezzi, uno controlla il passaggio tra grezzo e weekly)? Li costruirai
nel capstone, se vuoi.

## Usalo
L'agente growth-challenger di Marco gira su ogni decisione kill/scale sopra circa 500 euro. Non
scrive mai; la decisione resta a lui. I team di agenti (meta, ASO, GEO) sono 23 ruoli in sola
lettura che girano in parallelo e passano i risultati a uno stratega. Un hook PreToolUse (fase
05) garantisce che nessuno di loro possa scrivere su Meta, Slack o Supabase mentre un team gira.

## Cosa ti resta
`.claude/agents/<canale>-analyst.md` e `reports/analyst-verdict.md`: una seconda opinione a chiamata.

## Check
`bin/check.sh 06` verifica: il file dell'agente esiste con `name:` e `tools:` · i tool non
contengono Write, Edit o Bash · `reports/analyst-verdict.md` esiste con `## Verdict` e
`## Weakest assumption`.

## Termini chiave
| Termine | Cosa dice la gente | Cosa vuol dire davvero |
|---|---|---|
| Agente / subagente | "un'altra AI" | Un Claude con il suo brief, i suoi tool e il suo contesto, lanciato per un compito; torna solo il messaggio finale. |
| tools: | "i permessi" | La lista chiusa di cosa puo' fare. Liste in sola lettura rendono gli agenti sicuri da far girare da soli. |
| model: | "il motore" | Quale Claude lo fa girare. Sonnet per lettura e routine, Opus per il ragionamento pesante a molti vincoli. |
| Team | "un workflow" | Piu' agenti con tool chiusi piu' uno che decide, spesso in parallelo. |

## Per approfondire
- Documentazione subagenti: https://code.claude.com/docs/en/sub-agents (frontmatter, tools, model, come si invocano)
