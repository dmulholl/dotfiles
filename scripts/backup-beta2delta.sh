#!/usr/bin/env bash
set -euo pipefail

termtitle red "Replicating backups from Beta (DHD) to Delta (PHD) using rsync."

# The slash at the end of the source directory path is important. It means
# copy the *contents* of the directory.
src="/Volumes/Beta/"

# A slash at the end of the destination path can cause problems when copying
# to the root of a drive.
dst="/Volumes/Delta/Backups/Beta"

# Check the destination directory exists.
if test ! -d $dst; then
    echo "Error: cannot locate $dst."
    exit 1
fi

# Increase the maximum number of files the process can have open.
ulimit -n 4096

# Run rsync in mirroring mode.
rsync -av --delete \
    --include "/Backups/***" \
    --exclude "**" \
    -- "$src" "$dst"
