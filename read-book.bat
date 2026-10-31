@echo off
REM Opens the Zero to Architect reader at http://localhost:8000/site/
cd /d "%~dp0"
where python >nul 2>nul && (set PY=python) || (set PY=py)
echo Starting the book at http://localhost:8000/site/
echo Keep this window open while you read. Close it to stop.
start "" http://localhost:8000/site/
%PY% -m http.server 8000 --bind 127.0.0.1
