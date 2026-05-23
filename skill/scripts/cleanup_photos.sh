#!/usr/bin/env bash
# cleanup_photos.sh -- list, delete, or archive stale images (>24h old) from
# the iCloud Drive ClaudeInbox folder.
#
# Usage:
#   bash cleanup_photos.sh list                   -- dry-run: list stale files
#   bash cleanup_photos.sh delete                 -- remove stale files
#   bash cleanup_photos.sh archive <dest_dir>     -- move stale files to dest_dir

set -euo pipefail

INBOX="${CLAUDE_PHOTO_INBOX:-$HOME/Library/Mobile Documents/com~apple~CloudDocs/ClaudeInbox}"

MODE="${1:-}"
DEST="${2:-}"

if [[ -z "$MODE" ]]; then
  echo "Usage: cleanup_photos.sh <list|delete|archive> [dest_dir]" >&2
  exit 1
fi

if [[ ! -d "$INBOX" ]]; then
  echo "ERROR: Inbox folder not found: $INBOX" >&2
  exit 1
fi

if [[ "$MODE" == "archive" && -z "$DEST" ]]; then
  echo "ERROR: archive mode requires a destination directory" >&2
  echo "Usage: cleanup_photos.sh archive <dest_dir>" >&2
  exit 1
fi

# Find image files older than 24 hours (-mtime +0 on macOS means >24h).
STALE=()
while IFS= read -r -d '' file; do
  STALE+=("$file")
done < <(
  find "$INBOX" -type f \( \
    -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \
    -o -iname '*.heic' -o -iname '*.heif' -o -iname '*.webp' -o -iname '*.gif' \
  \) -mtime +0 -print0 2>/dev/null
)

if [[ ${#STALE[@]} -eq 0 ]]; then
  # Nothing to do -- exit silently.
  exit 0
fi

case "$MODE" in
  list)
    for f in "${STALE[@]}"; do
      echo "$f"
    done
    echo "${#STALE[@]} stale file(s) found"
    ;;
  delete)
    for f in "${STALE[@]}"; do
      rm "$f"
    done
    echo "Deleted ${#STALE[@]} stale file(s)"
    ;;
  archive)
    mkdir -p "$DEST"
    for f in "${STALE[@]}"; do
      mv "$f" "$DEST/"
    done
    echo "Archived ${#STALE[@]} file(s) to $DEST"
    ;;
  *)
    echo "ERROR: unknown mode '$MODE' (use list, delete, or archive)" >&2
    exit 1
    ;;
esac
