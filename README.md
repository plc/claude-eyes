# Claude Eyes

Get iPhone photos into Claude Code with one button press.

No custom iOS app. Just an iCloud Drive folder, an iPhone Shortcut, and a Claude Code skill.

## How it works

1. Press the Action Button (or Back Tap) on your iPhone
2. Take a photo -- it saves to `ClaudeInbox` in iCloud Drive
3. In Claude Code, say "use my latest photo"

The skill finds the newest image in `ClaudeInbox`, converts HEIC to JPEG (Claude Code can't view HEIC), and copies it into your working directory.

## Setup

### 1. Install the skill

```bash
git clone https://github.com/plc/claude-eyes.git
cd claude-eyes
bash install.sh
```

This copies the skill to `~/.claude/skills/claude-eyes/` and creates the `ClaudeInbox` folder in iCloud Drive if it doesn't exist.

### 2. Build the iPhone Shortcut

Create a new Shortcut called **"Send to Claude"** with these four actions:

| # | Action | Settings |
|---|--------|----------|
| 1 | **Take Photo** | Rear camera, Show Preview on |
| 2 | **Convert Image** | To JPEG |
| 3 | **Set Name** | `claude-` + Current Date (format: `yyyy-MM-dd-HHmmss`) |
| 4 | **Save File** | To: iCloud Drive / `ClaudeInbox` -- "Ask Where to Save" **off** |

### 3. Bind the Shortcut

- **Action Button** (iPhone 15 Pro+): Settings > Action Button > Shortcut > Send to Claude
- **Back Tap** (any iPhone): Settings > Accessibility > Touch > Back Tap > Double/Triple Tap > Send to Claude

### 4. Test it

1. Trigger the Shortcut and take a photo
2. Wait a moment for iCloud to sync
3. In Claude Code: `use my latest photo`

## Usage

| Command | What it does |
|---------|--------------|
| "use my latest photo" | Imports the newest photo |
| "grab the last 3 photos" | Imports the 3 most recent photos |
| "look at the picture I just sent" | Same as above -- the skill triggers on natural phrasing |

## Configuration

Set `CLAUDE_PHOTO_INBOX` to override the default inbox location:

```bash
export CLAUDE_PHOTO_INBOX="/path/to/your/folder"
```

Default: `~/Library/Mobile Documents/com~apple~CloudDocs/ClaudeInbox`

## Troubleshooting

| Problem | Fix |
|---------|-----|
| "Inbox folder not found" | Run `install.sh` again, or create `ClaudeInbox` in iCloud Drive manually |
| "No images found" | Photo may still be syncing -- wait a few seconds and retry |
| Image is 0 bytes | iCloud hasn't downloaded it locally -- open the folder in Finder to force sync |
| Filename looks wrong | Check the Shortcut date format is `yyyy-MM-dd-HHmmss` (no colons) |

## Requirements

- macOS with iCloud Drive enabled
- iPhone with Shortcuts app
- Claude Code (the CLI)
- `sips` (ships with macOS -- used for HEIC-to-JPEG conversion)
