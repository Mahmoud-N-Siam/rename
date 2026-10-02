#!/bin/bash

# ============================================================
# RenameToJellyfin.command
# Renames scene-release episode files (e.g. "Show.Name.2024.S01E01...")
# into clean Jellyfin-friendly names: "Show Name S01E01.mkv"
#
# HOW TO USE:
# 1. Change SHOW_NAME below to match the show you're renaming.
# 2. Double-click this file (or run it) from Terminal while
#    sitting INSIDE the folder containing the episode files.
# 3. It renames every .mkv/.mp4/.avi file in that folder.
# ============================================================

# --- EDIT THIS LINE ONLY ---
SHOW_NAME="The Gentlemen"
# ----------------------------

# Move into the folder this script was double-clicked from
cd "$(dirname "$0")"

echo "Renaming episodes for: $SHOW_NAME"
echo "Working in: $(pwd)"
echo ""

# Loop over common video file extensions
for f in *.mkv *.mp4 *.avi; do
  # Skip if no files of this extension exist (avoids literal "*.mkv" error)
  [ -e "$f" ] || continue

  # Extract the SxxExx pattern (e.g. S01E07) from the filename
  ep=$(echo "$f" | grep -oE '[Ss][0-9]{2}[Ee][0-9]{2}')

  if [ -z "$ep" ]; then
    echo "Skipping (no SxxExx found): $f"
    continue
  fi

  # Keep the original file extension
  ext="${f##*.}"

  # Build the new clean filename
  newname="$SHOW_NAME ${ep^^}.$ext"   # ${ep^^} forces uppercase S/E

  echo "Renaming: $f"
  echo "     ->   $newname"
  mv "$f" "$newname"
done

echo ""
echo "Done. Press Enter to close this window."
read
