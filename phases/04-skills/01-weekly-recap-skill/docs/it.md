# Skill: il tuo recap settimanale in un comando

> Tutto quello che chiedi a Claude piu' di due volte e' una skill che aspetta di essere scritta. Scrivila una volta, lanciala con uno slash :)

**Badge:** ⚡ One-Command Wonder  ·  **Tempo:** ~2 h 30  ·  **Prerequisiti:** fase 03

## Cosa saprai fare
- Trasformare una richiesta ripetuta in `/<nome>`: una cartella, un `SKILL.md`, fatto.
- Scrivere una description che fa scegliere la skill a Claude da solo.
- Tenere la skill corta e spostare i dettagli in file di riferimento letti solo quando servono.

## Il problema
Ogni lunedi' scrivi le stesse 200 parole: "prendi l'export della settimana scorsa, dammi la
domanda, la risposta, una sezione per mercato, le fonti in fondo, in inglese, niente decisioni".
Stessa struttura, stessi errori quando dimentichi una riga, e nessun altro nel team puo' fare il
"tuo" recap perche' vive nella tua testa.

Una skill e' quel paragrafo, salvato. `/tiktok-weekly` e parte. I colleghi clonano il tuo
workspace e ce l'hanno anche loro. Marco fa il suo lunedi' con `/lunedi`, una skill che ne
chiama altre sei.

## Il concetto
```
.claude/skills/<nome>/
├── SKILL.md          frontmatter (name, description) + la procedura, passo per passo
├── references/       opzionale: la roba lunga (struttura del report, esempi), letta a richiesta
└── scripts/          opzionale: helper che la skill lancia
```
Il frontmatter e' il grilletto:
```yaml
---
name: tiktok-weekly
description: >
  Recap settimanale TikTok per Finanz IT, sulla struttura canonica del report (domanda, risposta,
  una sezione per mercato, fonti e limiti). Usa quando dico "weekly", "recap", "/tiktok-weekly",
  o il lunedi' mattina.
---
```
`name` deve essere uguale al nome della cartella. `description` e' quello che Claude legge per
decidere "e' questa la skill per quello che mi hanno chiesto?", quindi contiene le frasi che la
fanno scattare. Sotto il frontmatter: i passi, in ordine, cosa leggere, cosa produrre, cosa non
fare mai.

Progressive disclosure: il file della skill resta corto (cosa fare). I template lunghi vanno in
`references/` e la skill dice "leggi references/structure.md". Claude lo carica solo allora.

## Costruiscilo
### Passo 1: ruba la struttura
Leggi `reference/examples/skills/growth-status.SKILL.md` nel repo del corso. Nota: frontmatter,
poi passi numerati, poi regole. Quella e' la forma.

### Passo 2: scrivi la skill
Nel tuo workspace chiedi a Claude: "crea .claude/skills/<canale>-weekly/SKILL.md: name uguale
alla cartella, una description di almeno 80 caratteri con le frasi che la fanno scattare, e
questi passi: leggi reports/raw-W<nn>.md, scrivi reports/weekly-W<nn>.md con le sezioni
`## Question`, `## Answer`, una `## <mercato>` per mercato, `## Sources and limits`; in inglese;
solo analisi, niente decisioni; ogni numero etichettato". Leggi il file. Accorcia quello che puoi.

### Passo 3: sposta fuori il template
Crea `references/structure.md` con i titoli esatti e una regola di una riga per sezione. In
SKILL.md sostituisci la spiegazione lunga con "segui references/structure.md".

### Passo 4: lanciala
`/clear`, poi `/<canale>-weekly`. Guardala leggere il report grezzo e scrivere quello
settimanale. Apri `reports/weekly-W<nn>.md`. Ogni numero e' etichettato? La sezione Sources e'
onesta? Correggi la skill, non l'output, e rilancia. Una skill corretta una volta e' corretta per sempre.

### Passo 5: scatta senza lo slash
`/clear`, poi scrivi "mi fai il weekly?". Se Claude sceglie la tua skill, la description funziona.
Se no, aggiungi alla description la frase che hai appena usato.

## Usalo
`/acquisition-report` di Marco e' 300 righe piu' un file di riferimento con la struttura fissa di
ogni report dal 25 set 2026. `/lunedi` lo incatena con il refresh del motore, le decisioni di
scaling e l'email all'advisor. Entrambi sono nati come un paragrafo che era stanco di riscrivere.

## Cosa ti resta
`.claude/skills/<canale>-weekly/` nel tuo workspace, e il recap di questa settimana fatto da lei.

## Check
`bin/check.sh 04` verifica: una cartella skill `*-weekly` con `SKILL.md` · `name:` uguale alla
cartella · description di 80+ caratteri · `reports/weekly-Wnn.md` esiste con una sezione `Answer`
e una `Sources`.

## Termini chiave
| Termine | Cosa dice la gente | Cosa vuol dire davvero |
|---|---|---|
| Skill | "un template di prompt" | Una cartella con SKILL.md: procedura + grilletto, invocata come /nome o scelta da Claude. |
| description | "il sottotitolo" | Il grilletto. Claude confronta le tue parole con quella. Mettici le frasi che dici davvero. |
| Progressive disclosure | "un di piu'" | SKILL.md corto, riferimenti lunghi letti solo quando servono. Tiene leggero il contesto. |
| Slash command | "il vecchio modo" | `.claude/commands/*.md` funziona ancora; le skill sono la stessa idea con cartella e riferimenti. |

## Per approfondire
- Documentazione skill: https://code.claude.com/docs/en/skills (campi del frontmatter, allowed-tools, argomenti)
