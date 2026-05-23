#!/usr/bin/env bash
# get_latest_photo.sh -- copy the newest image(s) from the iCloud Drive
# ClaudeInbox folder into the current directory, converting HEIC to JPEG.
#
# Usage: bash get_latest_photo.sh [count]   (count defaults to 1)

set -euo pipefail

INBOX="${CLAUDE_PHOTO_INBOX:-$HOME/Library/Mobile Documents/com~apple~CloudDocs/ClaudeInbox}"
COUNT="${1:-1}"

if [[ ! -d "$INBOX" ]]; then
  echo "ERROR: Inbox folder not found: $INBOX" >&2
  echo "Create it in iCloud Drive, or set CLAUDE_PHOTO_INBOX to your folder." >&2
  exit 1
fi

# Newest-first list of image files, sorted by modification time (BSD stat).
FILES=()
while IFS= read -r line; do
  FILES+=("${line#* }")
done < <(
  find "$INBOX" -type f \( \
    -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \
    -o -iname '*.heic' -o -iname '*.heif' -o -iname '*.webp' -o -iname '*.gif' \
  \) -print0 2>/dev/null \
    | xargs -0 stat -f '%m %N' 2>/dev/null \
    | sort -rn \
    | head -n "$COUNT"
)

if [[ ${#FILES[@]} -eq 0 ]]; then
  echo "ERROR: No images found in $INBOX" >&2
  echo "The latest photo may still be syncing from iCloud -- wait a moment and retry." >&2
  exit 1
fi

for SRC in "${FILES[@]}"; do
  BASE="$(basename "$SRC")"
  EXT_LC="$(printf '%s' "${BASE##*.}" | tr '[:upper:]' '[:lower:]')"
  if [[ "$EXT_LC" == "heic" || "$EXT_LC" == "heif" ]]; then
    DEST="./${BASE%.*}.jpg"
    sips -s format jpeg "$SRC" --out "$DEST" >/dev/null
  else
    DEST="./$BASE"
    cp "$SRC" "$DEST"
  fi
  echo "$DEST"
done
