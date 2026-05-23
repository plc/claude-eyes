# Claude Eyes

## What this is

Master repo for the claude-eyes skill -- an iPhone-to-Claude-Code photo pipeline.

Components:
- `skill/` -- the Claude Code skill (SKILL.md + get_latest_photo.sh)
- `install.sh` -- installs skill to `~/.claude/skills/claude-eyes/` and creates `ClaudeInbox`

## Architecture

```
iPhone Shortcut (Take Photo > Convert JPEG > Timestamp name > Save)
    |
    v
iCloud Drive / ClaudeInbox/
    |
    v (iCloud sync)
~/Library/Mobile Documents/com~apple~CloudDocs/ClaudeInbox/
    |
    v (skill script)
Working directory (JPEG, ready to view)
```

## Key decisions

- HEIC converted to JPEG at import time because Claude Code can't read HEIC
- Uses `sips` (built into macOS) for conversion -- no third-party dependencies
- Skill name in the installed SKILL.md is `claude-eyes` (renamed from `latest-photo`)
- Filename format: `claude-yyyy-MM-dd-HHmmss.jpeg` (no colons -- colons break filenames on macOS)
- `CLAUDE_PHOTO_INBOX` env var overrides the default inbox path

## Open items

- Share-sheet variant of the Shortcut (send existing photos, not just freshly taken ones)
- Auto-cleanup of old files in ClaudeInbox
- Investigate adding a share-sheet Shortcut that sends existing Camera Roll photos

## File layout

```
claude-eyes/
  skill/
    SKILL.md              -- skill definition (installed to ~/.claude/skills/claude-eyes/)
    scripts/
      get_latest_photo.sh -- the import script
  install.sh              -- installer
  README.md               -- user-facing docs
  CLAUDE.md               -- this file
  CHANGELOG.md            -- project history
```
