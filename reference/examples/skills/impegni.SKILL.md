---
name: impegni
description: >
  Registro degli impegni di Marco: cose che altri gli devono consegnare e cose che deve fare lui,
  con scadenza. Scrive, elenca e chiude le righe di .claude/commitments.json. L'avviso arriva da
  solo (hook commitments-reminder.sh: due giorni prima della scadenza, e la lista completa il
  lunedi) — questa skill serve a METTERE dentro le cose e a CHIUDERLE. Usa quando Marco dice
  "segna che", "ricordami", "X mi deve consegnare", "devo fare", "mi serve entro", "scadenza",
  "impegni", "/impegni", "cosa mi devono", "chi mi deve cosa", "l'ha consegnato", "fatto",
  o quando in una conversazione qualcuno si prende un impegno verso di lui con una data.
---

# /impegni — chi deve cosa, entro quando

Il registro e' `.claude/commitments.json`. Una riga per impegno:

```json
{ "id": "mike-ricavo-gen-lug", "who": "Mike", "what": "ricavo gen-lug per mercato",
  "due": "2026-09-22", "status": "open", "created": "2026-09-17", "note": "chiesto in sprint call" }
```

- `who` — chi deve consegnare. `"marco"` se e' roba sua. Il nome della persona altrimenti, come lo
  usa lui (Lore, Mike, Stan, Simone, Longo, Matteo, Sprea).
- `what` — il deliverable, non l'argomento. "il ricavo gen-lug per mercato", non "revenue".
- `due` — `YYYY-MM-DD`, oppure `null` se non c'e' una data: senza data esce solo nella lista del lunedi.
- `status` — `open` | `done` | `dropped`. Le righe chiuse restano, sono lo storico.
- `id` — slug `chi-cosa`, minuscolo, unico.

## Aggiungere
Scrivi la riga con `jq` e rileggi il file per confermare (regola: verificare prima di dire fatto).

```bash
cd /Users/marco/Claude_Code
jq '.commitments += [{"id":"<id>","who":"<chi>","what":"<cosa>","due":"<YYYY-MM-DD o null>",
    "status":"open","created":"'"$(date +%F)"'","note":"<dove e quando e stato chiesto>"}]' \
  .claude/commitments.json > /tmp/c.json && mv /tmp/c.json .claude/commitments.json
jq -r '.commitments[-1]' .claude/commitments.json
```

**Due date mancante.** Se Marco dice "mi deve mandare i dati" senza data, chiedi una data sola volta,
in linea, e se non la da' metti `null`. Non inventare una scadenza: una scadenza falsa fa scattare un
avviso falso, ed e' peggio di nessun avviso.

**Date relative.** "lunedi", "fine settimana", "fra due settimane" si convertono in `YYYY-MM-DD`
assoluta prima di scrivere, con `date -v`. Nel registro non entrano mai date relative.

## Elencare
Tabella secca, ordinata per scadenza, scaduti in cima. Solo `open` salvo richiesta diversa.
Separa **chi mi deve cosa** da **cosa devo fare io** (`who == "marco"`): sono due azioni diverse,
sollecitare e fare.

```bash
jq -r '.commitments[] | select(.status=="open") | [.due // "—", .who, .what, .id] | @tsv' \
  .claude/commitments.json | sort
```

## Chiudere
```bash
jq '(.commitments[] | select(.id=="<id>")).status = "done"' .claude/commitments.json > /tmp/c.json \
  && mv /tmp/c.json .claude/commitments.json
jq -r '.commitments[] | select(.id=="<id>")' .claude/commitments.json
```
`dropped` quando l'impegno decade, non quando scade: uno scaduto resta `open` e continua a bussare.

## Regole
- **Il registro e' scrittura, non azione.** Segnare che Mike deve consegnare non vuol dire
  scrivergli. Nessun messaggio a nessuno senza un via esplicito di Marco per quel singolo invio.
- **Non aprire un tab nuovo per un dato nuovo.** Campi extra (priorita', progetto, tag) solo se
  Marco li chiede: finche' non servono, cinque campi bastano.
- **Chiudi al volo.** Quando in conversazione risulta che una consegna e' arrivata, marca `done`
  subito e dillo in una riga, senza farne un passaggio a parte.
