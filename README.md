# RenameTVJellyfin

A small, double-clickable macOS utility that transforms messy **scene-release** TV filenames into clean, Jellyfin-friendly names.

Example transformation:
```
The.Gentlemen.S01E01.WEB-DL.DV.H.265.1080p-GROUP.mkv  →  The Gentlemen S01E01.mkv
```

## What it does

- Renames every `.mkv`, `.mp4`, or `.avi` file **in the same folder as the script** into `Show Name SxxExx.<ext>`.
- Extracts the `S01E07` episode code directly from the original filename (case‑insensitive), so it works with `s01e07`, `S01E07`, etc.
- Skips files that contain **no episode pattern**, leaving them untouched—there's nothing worse than silently misnaming an episode.
- Keeps the original file extension and upper‑cases the episode code (`S01E07`), giving you a consistently tidy result.

## Before you run it

1. **Place `RenameTVJellyfin.command` *inside* the folder that contains the episode files you want to rename.**  
   The script executes `cd "$(dirname "$0")"`—it runs from the folder it lives in, so it must sit alongside the episodes.
2. Open the script in a text editor and set `SHOW_NAME` to the exact name you want Jellyfin to display, e.g.:  
   ```bash
   SHOW_NAME="The Gentlemen"
   ```
3. If you copied the script via Terminal, make it executable:  
   ```bash
   chmod +x RenameTVJellyfin.command
   ```

## How to run

**Option A – The Finder way (recommended on macOS)**  
1. Drop `RenameTVJellyfin.command` into the folder with your episodes.  
2. Double‑click it. A Terminal window opens, shows each rename (`Renaming: … → …`), and pauses at the end so you can review the output.  
3. Press **Enter** when you're done to close the window.

**Option B – From Terminal**  
```bash
cd /path/to/your/episodes
./RenameTVJellyfin.command   # or: bash RenameTVJellyfin.command
```

## Example session

```
Renaming episodes for: The Gentlemen
Working in: /Volumes/Transcend/TV Shows/The Gentlemen/Season 01

Renaming: The.Gentlemen.S01E01.WEB-DL.DV.H.265.1080p-GROUP.mkv
     ->   The Gentlemen S01E01.mkv
Renaming: The.Gentlemen.S01E02.WEB-DL.DV.H.265.1080p-GROUP.mkv
     ->   The Gentlemen S01E02.mkv
Skipping (no SxxExx found): Sample.mkv
...
Done. Press Enter to close this window.
```

## Things to be aware of

- **One episode code per file** – A file covering a range like `S01E01-02` is renamed using only the **first** code (`S01E01`). If you have multi‑episode files, split them first or rename them manually.
- **Only `.mkv`, `.mp4`, `.avi` are processed** – Other files (`.nfo`, `.jpg`, samples, `.rar`, etc.) are ignored. Edit the `for f in *.mkv *.mp4 *.avi` line at the top of the script to add more extensions.
- **No undo** – The `mv` command is destructive. Always review the printed `->` lines carefully before confirming, or test in a throwaway copy of your folder first.
- **Non‑recursive** – The script only touches files in its own folder; it does **not** descend into subfolders.
- **Episode code required** – Files without an `SxxExx` pattern (e.g., `01.mkv`, `pilot.mp4`) are skipped intentionally.

## Requirements

- macOS (or any Unix‑like system) with `bash`, `grep -E`, and `mv`.
- No extra dependencies; the script uses only built‑in shell commands.

## Safety tip – Preview first

Want to see what would happen without touching any files? Temporarily change the `mv` line to `mv -n` (dry‑run mode) and run the script once. It will show the planned renames but leave your files intact.

## Files

| File | Purpose |
|------|---------|
| `RenameTVJellyfin.command` | Double-clickable script that renames scene‑release episodes |
| `README.md` | This document |

---

Provided as‑is for your personal media library.