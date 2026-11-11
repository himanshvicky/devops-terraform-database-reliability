
#!/bin/bash
set -euo pipefail

: "${PGHOST:=localhost}"
: "${PGPORT:=5432}"
: "${PGDATABASE:=bookings}"
: "${PGUSER:=assessment}"

BACKUP_DIR="${BACKUP_DIR:-./backups}"

if [ -z "${PGPASSWORD:-}" ]; then
    echo "Error: PGPASSWORD is not set"
    exit 1
fi

BACKUP_FILE="${1:-}"

if [ -z "$BACKUP_FILE" ]; then
    BACKUP_FILE=$(ls -t "$BACKUP_DIR"/*.dump 2>/dev/null | head -n 1 || true)
fi

if [ -z "$BACKUP_FILE" ] || [ ! -f "$BACKUP_FILE" ]; then
    echo "Error: No valid backup file found"
    exit 1
fi

export PGPASSWORD

pg_restore \
    -h "$PGHOST" \
    -p "$PGPORT" \
    -U "$PGUSER" \
    -d "$PGDATABASE" \
    --no-owner \
    --exit-on-error \
    "$BACKUP_FILE"

echo "Database restoration completed successfully"
