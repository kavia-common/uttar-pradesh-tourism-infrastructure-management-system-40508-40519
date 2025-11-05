# Quick Connection Guide

- psql CLI using standardized env vars (defaults shown):
  - POSTGRES_HOST=localhost
  - POSTGRES_PORT=5001
  - POSTGRES_DB=myapp
  - POSTGRES_USER=appuser
  - POSTGRES_PASSWORD=dbuser123

Example:

psql "postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}"

Or with defaults:

psql "postgresql://appuser:dbuser123@localhost:5001/myapp"

If you ran startup.sh, you can also use:

$(cat db_connection.txt 2>/dev/null || echo "psql postgresql://appuser:dbuser123@localhost:5001/myapp")
