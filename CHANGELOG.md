# Changelog

## 2026-05-23 -- Initial repo setup

- Created master repo for the claude-eyes skill
- Copied skill source from `~/.claude/skills/claude-eyes/` into `skill/`
- Added `install.sh` for one-command setup
- Created README.md with full setup instructions (Shortcut build steps, binding, usage)
- Created CLAUDE.md with architecture notes and open items
- Renamed skill from `latest-photo` to `claude-eyes`
- Documented filename format fix: Shortcut date format should be `yyyy-MM-dd-HHmmss` (no colons -- colons are illegal in macOS filenames and break the date format)

### Known issue: Shortcut date format

The existing iPhone Shortcut produces filenames like `claude-01-Jan-01-10:08:07.jpeg` instead of `claude-2026-05-23-100807.jpeg`. The "Set Name" action's date format needs to be `yyyy-MM-dd-HHmmss` (custom format, not a locale preset). This must be fixed manually in the Shortcuts app.

### Open items

- Share-sheet variant Shortcut for sending existing photos (not just camera)
- Auto-cleanup of old ClaudeInbox files
