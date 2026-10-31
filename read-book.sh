#!/usr/bin/env sh
# Opens the Zero to Architect reader at http://localhost:8000/site/
cd "$(dirname "$0")"
echo "Book running at http://localhost:8000/site/  (Ctrl+C to stop)"
( sleep 1; (command -v xdg-open >/dev/null && xdg-open http://localhost:8000/site/) || (command -v open >/dev/null && open http://localhost:8000/site/) ) >/dev/null 2>&1 &
python3 -m http.server 8000 --bind 127.0.0.1
