# Strumenti e sessioni: da un CSV a un report

> Claude Code ha sei mani: Read, Edit, Bash, Glob, Grep, Write. Impara quale sta usando e smetti di sorprenderti :)

**Badge:** 🛠️ Toolsmith  ·  **Tempo:** ~1 h 30  ·  **Prerequisiti:** fase 02

## Cosa saprai fare
- Leggere cosa sta facendo Claude: quale tool, su quale file, perche' chiede.
- Impostare i permessi una volta in `settings.json` invece di dire si' quaranta volte.
- Trasformare un export grezzo in un report con fonte, e far girare Claude senza sessione (headless).

## Il problema
Esporti i numeri della settimana scorsa da Adjust o dall'Engine. Un CSV. Lo apri, scorri, copi
tre cifre in un messaggio, perdi il filtro che hai usato, e lunedi' nessuno sa ricostruire il numero.

Claude puo' fare la parte noiosa: leggere il file, sommare le colonne, scrivere una tabella, e
scrivere da dove viene il file. Ma solo se capisci cosa sta facendo con i tuoi file, cosi' dici
si' in fretta e no quando conta.

## Il concetto
```
 Read    guarda un file                       libero, nessuna domanda
 Glob    trova file per nome (*.csv)          libero
 Grep    cerca testo dentro i file            libero
 Edit    cambia una parte di un file          chiede (se non permesso)
 Write   crea o sovrascrive un file           chiede (se non permesso)
 Bash    lancia un comando (ls, python, git)  chiede (se non permesso)
```
I permessi vivono in `.claude/settings.json` del workspace:
```json
{ "permissions": { "allow": ["Read", "Bash(ls:*)", "Bash(git status:*)"],
                   "deny":  ["Bash(rm:*)"],
                   "ask":   ["Write"] } }
```
`allow` = silenzioso. `deny` = mai. `ask` = il default. Le impostazioni di progetto le condivide
chi clona la cartella; `settings.local.json` e' solo tuo.

Sessioni: `claude` parte da zero. `claude --continue` riapre l'ultima, `claude --resume` ti fa
scegliere. `/compact` schiaccia un contesto lungo in un riassunto quando Claude inizia a
dimenticare. `/cost` ti dice quanto ha consumato la sessione. Plan mode (Shift+Tab due volte) fa
pensare e proporre Claude senza toccare file: perfetto per "tu cosa faresti qui?".

Headless: `claude -p "il tuo prompt"` esegue un prompt, stampa una risposta, nessuna sessione.
E' cosi' che script e scheduler usano Claude. Rispetta lo stesso CLAUDE.md.

## Costruiscilo
### Passo 1: procurati un CSV
Esporta la settimana scorsa dallo strumento del tuo canale (Adjust, Mixpanel, l'Engine, Meta).
Salvalo come `work/week.csv` nel tuo workspace. Nessun export a portata? Copia
`outputs/sample-week.csv.example` in `work/week.csv` ed etichetta tutto ASSUMED dopo.

### Passo 2: guarda i tool
Chiedi a Claude: "cosa c'e' in work/week.csv?". Guarda la riga che stampa prima della risposta:
quello e' un Read. Chiedi "quali file qui sono csv?": Glob. Chiedi "quale riga ha la spesa piu'
alta?": potrebbe lanciare un comando Bash con awk o python. Ogni volta, nota il nome del tool.

### Passo 3: il report
Chiedi: "scrivi reports/raw-W<nn>.md (nn = settimana ISO corrente): una tabella markdown con i
totali per le colonne che contano, ogni numero MEASURED da work/week.csv, e una riga finale
`Source: <strumento>, <nome report>, <filtro>, esportato il <data>`". Dagli la fonte vera.
Chiede di scrivere: si'. Apri il file. Controlla un totale a mano contro il CSV. Uno. Sempre.

### Passo 4: smetti di dire si'
Crea `.claude/settings.json` nel workspace con `allow` per `Read`, `Bash(ls:*)`, `Bash(cat:*)`,
`Bash(git status:*)` e `deny` per `Bash(rm:*)`. Riavvia `claude`. Chiedi un elenco: stavolta
nessuna domanda.

### Passo 5: headless
Nel Terminale, dal tuo workspace, lancia:
`claude -p "Write the single word ok to reports/headless-ok.txt and nothing else" --allowedTools Write`
Poi `cat reports/headless-ok.txt`. Un prompt, nessuna sessione, un file. La fase 05 lo fa girare
a orario.

## Usalo
Il report acquisition settimanale di Marco parte esattamente cosi': export grezzi letti da Claude,
totali controllati una volta a mano, una sezione `Sources and limits` in fondo a ogni report. Il
suo `settings.local.json` ha 416 regole allow, costruite in cinque mesi, un "permetti sempre" alla volta.

## Cosa ti resta
`reports/raw-W<nn>.md` con una riga Source, e un `settings.json` su misura delle tue mani.

## Check
`bin/check.sh 03` verifica: `reports/raw-Wnn.md` esiste · ha una tabella · una riga `Source:` ·
`reports/headless-ok.txt` esiste e contiene `ok`.

## Termini chiave
| Termine | Cosa dice la gente | Cosa vuol dire davvero |
|---|---|---|
| Tool | "una funzione" | Una capacita' con il suo permesso: Read, Edit, Write, Bash, Glob, Grep, e le chiamate MCP. |
| settings.json | "la config" | Permessi, hook, env. Il file di progetto si condivide; `.local.json` e' tuo. |
| Plan mode | "modalita' pensiero" | Claude esplora e propone, non scrive niente. Esci per eseguire. |
| /compact | "pulisci" | Riassume il contesto invece di cancellarlo. Usalo quando le risposte diventano vaghe. |
| Headless | "modalita' API" | `claude -p`: un prompt dentro, una risposta fuori, scriptabile. |

## Per approfondire
- Permessi e impostazioni: https://code.claude.com/docs/en/settings
- Riferimento CLI (`-p`, `--continue`, `--resume`, `--allowedTools`): https://code.claude.com/docs/en/cli-reference
