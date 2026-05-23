---
name: claude-eyes
description: Pull the most recent photo(s) from the user's iPhone into the working directory so Claude can see them. Use this whenever the user refers to a photo they just took or sent from their phone — phrases like "use my latest photo", "the photo I just took", "grab the last photo", "import my iPhone photo", "look at the picture I just sent", or "pull in the last 3 photos". Trigger it even when the user doesn't say the word "skill" or name a file — if they mean a recent iPhone photo and there's no file already attached, use this skill.
---

# Claude Eyes

Imports the newest image(s) from the user's iCloud Drive `ClaudeInbox` folder into
the current directory. The user pushes photos there from their iPhone via a
Shortcut, so "the photo I just took" lives in that folder.

## How to use it

1. Run the script. By default it grabs the single newest image:

   ```
   bash scripts/get_latest_photo.sh
   ```

   To grab more than one, pass a count:

   ```
   bash scripts/get_latest_photo.sh 3
   ```

2. The script prints the path of each imported file (relative to the current
   directory). HEIC/HEIF photos are auto-converted to JPEG so they can be viewed.

3. View the imported file(s) to see the photo, then carry on with whatever the
   user asked.

## Failure modes

- **"Inbox folder not found"** -- the user hasn't set up the `ClaudeInbox` folder
  yet, or it lives elsewhere. They can create it in iCloud Drive, or point the
  skill at a different folder by setting `CLAUDE_PHOTO_INBOX` to its full path.
- **"No images found"** -- the folder exists but is empty, or the latest photo
  hasn't finished syncing from iCloud yet. Ask the user to wait a few seconds and
  try again.
- **A file looks empty / 0 bytes** -- iCloud may not have downloaded it locally.
  Re-running the script usually triggers the download; if not, the user can open
  the folder in Finder to force a sync.
