#!/usr/bin/env bash
# install.sh -- install the claude-eyes skill into ~/.claude/skills/
set -euo pipefail

SKILL_DIR="$HOME/.claude/skills/claude-eyes"

if [[ -d "$SKILL_DIR" ]]; then
  echo "Removing existing installation at $SKILL_DIR"
  rm -rf "$SKILL_DIR"
fi

mkdir -p "$SKILL_DIR/scripts"
cp skill/SKILL.md "$SKILL_DIR/SKILL.md"
cp skill/scripts/get_latest_photo.sh "$SKILL_DIR/scripts/get_latest_photo.sh"
cp skill/scripts/cleanup_photos.sh "$SKILL_DIR/scripts/cleanup_photos.sh"
chmod +x "$SKILL_DIR/scripts/get_latest_photo.sh"
chmod +x "$SKILL_DIR/scripts/cleanup_photos.sh"

echo "Installed claude-eyes skill to $SKILL_DIR"

# Create ClaudeInbox folder if it doesn't exist
INBOX="$HOME/Library/Mobile Documents/com~apple~CloudDocs/ClaudeInbox"
if [[ ! -d "$INBOX" ]]; then
  mkdir -p "$INBOX"
  echo "Created ClaudeInbox folder at: $INBOX"
else
  echo "ClaudeInbox folder already exists at: $INBOX"
fi

echo ""
echo "Done. Next steps:"
echo "  1. Build the 'Send to Claude' Shortcut on your iPhone (see README.md)"
echo "  2. Take a photo with the Shortcut"
echo "  3. In Claude Code, say 'use my latest photo'"
