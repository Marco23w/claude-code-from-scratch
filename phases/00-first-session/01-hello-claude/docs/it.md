# Hello Claude: la tua prima sessione

> Claude Code e' un terminale che risponde. Tu scrivi, lui legge i tuoi file, li modifica, lancia comandi. Con il tuo si'. Tutto qui :)

**Badge:** 🐣 Hello Claude  ·  **Tempo:** ~45 min  ·  **Prerequisiti:** nessuno

## Cosa saprai fare
- Aprire Claude Code in una cartella e sapere cosa vede.
- Dire si' (o no) a quello che vuole fare, e capire perche' lo chiede.
- Fargli creare il tuo primo file, e poi trovarlo con i tuoi occhi.

## Il problema
Hai usato Claude nel browser. Incolli, risponde, copi. Poi incolli la risposta in un doc, un
foglio, un messaggio Slack. Il lavoro sta dalla tua parte del vetro.

Claude Code porta Claude dalla tua parte: nella cartella dove vivono i tuoi report, i CSV, gli
appunti. Puo' leggerli, scriverli, lanciare cose. Bellissimo, e un po' da paura. Quindi la prima
cosa da imparare non e' "come si scrive il prompt". E': cosa vede, cosa puo' toccare, quando chiede.

## Il concetto
```
   tu  --prompt-->  Claude Code  --legge-->  i file in questa cartella (e sotto)
                         |
                         +--vuole-->  modificare un file / lanciare un comando
                         |                    |
                         +<-- ti chiede: permetto? (una volta / sempre / no)
                         |
                         +--lo fa-->  ti mostra cosa e' cambiato
```
Tre idee:
1. **La cartella e' il mondo.** Claude vede la cartella in cui l'hai aperto. Non tutto il Mac.
2. **I tool chiedono un si'.** Leggere e' libero. Modificare e lanciare comandi chiedono prima.
   "Permetti sempre" e' una promessa che vale solo per questa cartella.
3. **Il contesto e' quello che ha letto finora.** File, i tuoi messaggi, le sue risposte. Nuova
   sessione = contesto vuoto, tranne `CLAUDE.md` (fase 01, spoiler).

## Costruiscilo
### Passo 1: aprilo
Nel Terminale: `cd ~/Finanz/growth-os` (il tuo workspace, creato dal setup) poi `claude`.
Vedi un prompt. Scrivi `/help` -> la lista dei comandi. Scrivi `/status` -> quale modello, quale
cartella. Quella riga della cartella e' il "mondo" del concetto qui sopra.

### Passo 2: chiedigli una cosa innocua
Scrivi: "che file ci sono in questa cartella?" -> lancia un elenco e te lo dice. Nessun
permesso chiesto: leggere e' libero.

### Passo 3: fallo scrivere
Scrivi (a parole tue): "crea work/hello.md con il mio handle GitHub <handle>, la data di oggi in
formato YYYY-MM-DD e il mio canale growth <canale>, come appunto al me del futuro".
Ti chiede di creare il file -> di' si'. Poi apri il file tu: `cat work/hello.md`. Leggilo. E' la
prima cosa che Claude ha scritto sulla tua macchina :)

### Passo 4: cambia idea
Chiedi: "aggiungi una riga: 'primo badge in arrivo...'". Chiede di nuovo? Allora il si' di prima
era "una volta". Prova "permetti sempre per questa sessione" e nota che smette di chiedere per
quel tool.

### Passo 5: pulisci e guarda cosa si perde
Scrivi `/clear`. Chiedi: "cosa abbiamo appena scritto?" -> non lo sa. Contesto nuovo. Quel
problema di memoria e' esattamente quello che la fase 01 risolve.

## Usalo
Marco apre Claude Code in una cartella con 26 progetti, 23 skill e 31 agenti. La prima cosa che
fa in ogni sessione e' leggere le regole della cartella, non aspettare un prompt. Alla fase 08
vedrai come. Per ora: anche lui dice si' o no a ogni scrittura fuori dalla sua allowlist. Il si'/no
e' il lavoro.

## Cosa ti resta
`work/hello.md`: il tuo primo artefatto. Piccolo, ma vero. Il check lo legge.

## Check
`bin/check.sh 00` verifica: il file esiste · contiene il tuo handle · una data ISO · il tuo canale.

## Termini chiave
| Termine | Cosa dice la gente | Cosa vuol dire davvero |
|---|---|---|
| Contesto | "la memoria di Claude" | Quello che ha letto in questa sessione. Sparisce con /clear. |
| Permesso | "chiede di nuovo, che palle" | Uno stop di sicurezza prima di una scrittura o un comando. Le allowlist lo zittiscono. |
| Sessione | "la chat" | Un giro di `claude` in una cartella. Gli hook ne registrano inizio e fine (e' il tracking del corso). |

## Per approfondire
- Claude Code quickstart: https://code.claude.com/docs/en/quickstart (10 minuti, il tour ufficiale)
