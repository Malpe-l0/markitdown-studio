# MarkItDown Studio

Interfaccia locale per convertire documenti in Markdown con [Microsoft MarkItDown](https://github.com/microsoft/markitdown). Include frontend, backend e script di avvio per macOS e Windows: **non serve clonare a parte il repository Microsoft**.

## Requisiti

- Python 3.10–3.14 (anche Python 3.13 va bene)
- Node.js LTS, che include `npm`
- Connessione Internet al primo avvio per installare le dipendenze

## Avvio su Windows

1. Installa Python 3.10–3.14 da [python.org](https://www.python.org/downloads/) e Node.js LTS da [nodejs.org](https://nodejs.org/).
2. Scarica/clona questo progetto sul PC.
3. Fai doppio clic su **Avvia MarkItDown Windows.bat**.
4. Al primo avvio vengono creati l’ambiente Python e installate le dipendenze; si aprirà l’interfaccia su http://127.0.0.1:5173.

Lo script apre due finestre di terminale minimizzate per i server: lasciale aperte mentre usi l’app. Chiudendole si interrompono i server.

## Avvio su Mac

Con Python 3.10–3.14 e Node.js LTS installati, fai doppio clic su **Avvia MarkItDown.command**. Al primo avvio installa le dipendenze e apre l’interfaccia nel browser. Lascia aperta la finestra Terminale mentre la usi.

## Avvio manuale

Backend Python:

```bash
python -m venv .venv
# macOS/Linux
source .venv/bin/activate
# Windows PowerShell: .venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
python -m uvicorn server.main:app --reload --port 8000
```

In un secondo terminale, dalla cartella del progetto:

```bash
npm install
npm run dev
```

## Uso

Trascina un file nell’area di caricamento o selezionalo dal dispositivo. Premi **Converti in Markdown**, poi copia il risultato o scaricalo come `.md`. Il server rimuove il file temporaneo al termine della conversione e accetta file fino a 50 MB. Sono inclusi gli extra PDF, Word, PowerPoint ed Excel; per altri formati puoi modificare gli extra in `requirements.txt` secondo la documentazione MarkItDown.
