@echo off
setlocal
cd /d "%~dp0"

where py >nul 2>nul
if errorlevel 1 (
  echo Python Launcher non trovato. Installa Python 3.14 da python.org e seleziona l'opzione Python Launcher.
  pause
  exit /b 1
)
set "PYTHON_VERSION="
for %%V in (3.10 3.11 3.12 3.13 3.14) do (
  py -%%V --version >nul 2>nul && set "PYTHON_VERSION=%%V"
)
if "%PYTHON_VERSION%"=="" (
  echo Non trovo Python 3.10-3.14. Installa una versione supportata da python.org e riprova.
  pause
  exit /b 1
)
where npm >nul 2>nul
if errorlevel 1 (
  echo Node.js/npm non trovato. Installa Node.js LTS e riprova.
  pause
  exit /b 1
)

if not exist .venv (
  py -%PYTHON_VERSION% -m venv .venv
  if errorlevel 1 (pause & exit /b 1)
)
if not exist .venv\Scripts\uvicorn.exe (
  .venv\Scripts\python.exe -m pip install -r requirements.txt
  if errorlevel 1 (pause & exit /b 1)
)
if not exist node_modules (
  npm install
  if errorlevel 1 (pause & exit /b 1)
)

start "MarkItDown API" /D "%CD%" cmd /k ".venv\Scripts\python.exe -m uvicorn server.main:app --host 127.0.0.1 --port 8000"
start "MarkItDown UI" /D "%CD%" cmd /k "npm run dev -- --host 127.0.0.1"
timeout /t 3 >nul
start "" http://127.0.0.1:5173
