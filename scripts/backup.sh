
#!/bin/bash
set -euo pipefail

: "${PGHOST:=localhost}"
: "${PGPORT:=5432}"
: "${PGDATABASE:=bookings}"
: "${PGUSER:=assessment}"

BACKUP_DIR="${BACKUP_DIR:-./backups}"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

mkdir -p "$BACKUP_DIR"

export PGPASSWORD="${PGPASSWORD:?Set PGPASSWORD first}"

pg_dump \
  -h "$PGHOST" \
  -p "$PGPORT" \
  -U "$PGUSER" \
  -d "$PGDATABASE" \
  -F c \
  -f "$BACKUP_DIR/backup_$TIMESTAMP.dump"

echo "Backup completed successfully"
