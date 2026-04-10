#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: backup.sh <vault-path>"
  exit 1
fi

VAULT="$(cd "$1" && pwd)"
BACKUP_DIR="${VAULT}/.ops/backups"
mkdir -p "$BACKUP_DIR"
TS="$(date -u +%Y%m%d-%H%M%S)"
OUT="${BACKUP_DIR}/vault-backup-${TS}.tar.gz"

tar --exclude='.ops/backups/*.tar.gz' -czf "$OUT" -C "$VAULT" raw wiki outputs WIKI_SCHEMA.md .ops >/dev/null 2>&1

echo "Backup created: $OUT"
