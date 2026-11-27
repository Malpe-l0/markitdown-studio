#!/bin/zsh
set -e
APP_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$APP_DIR"

PYTHON_BIN=""
for candidate in python3.10 python3.11 python3.12 python3.13 python3.14; do
  if command -v "$candidate" >/dev/null 2>&1; then PYTHON_BIN="$candidate"; fi
done
if [[ -z "$PYTHON_BIN" ]]; then
  echo "Non trovo Python 3.10–3.14. Installa una versione supportata e riprova."
  read -k 1 "?Premi un tasto per chiudere..."
  exit 1
fi
if ! command -v npm >/dev/null 2>&1; then
  echo "Node.js/npm non trovato. Installa Node.js e riprova."
  read -k 1 "?Premi un tasto per chiudere..."
  exit 1
fi

[[ -d .venv ]] || "$PYTHON_BIN" -m venv .venv
if ! .venv/bin/python -c 'import fastapi, markitdown' >/dev/null 2>&1; then
  .venv/bin/python -m pip install -r requirements.txt
fi
[[ -d node_modules ]] || npm install

cleanup() { kill "$API_PID" "$WEB_PID" 2>/dev/null || true; }
trap cleanup EXIT INT TERM
.venv/bin/uvicorn server.main:app --host 127.0.0.1 --port 8000 &
API_PID=$!
npm run dev -- --host 127.0.0.1 &
WEB_PID=$!
sleep 2
open http://127.0.0.1:5173
wait "$WEB_PID"
