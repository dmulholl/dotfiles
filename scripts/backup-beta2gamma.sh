#!/usr/bin/env bash
set -euo pipefail

termtitle green "Backing up Beta (DHD) to Gamma (PHD) using rsync."

# The slash at the end of the source directory path is important. It means
# copy the *contents* of the directory.
src="/Volumes/Beta/"

# A slash at the end of the destination path can cause problems when copying
# to the root of a drive.
dst="/Volumes/Gamma"

# Check the destination directory exists.
if test ! -d $dst; then
    echo "Error: cannot locate $dst."
    exit 1
fi

# Increase the maximum number of files the process can have open.
ulimit -n 4096

# Run rsync in mirroring mode.
rsync -av --delete \
    --exclude ".Spotlight*" \
    --exclude ".DS_Store" \
    --exclude ".DocumentRevisions*" \
    --exclude ".Trashes" \
    --exclude ".[Tt]rash" \
    --exclude ".fseventd" \
    --exclude ".fseventsd" \
    --exclude ".TemporaryItems" \
    -- "$src" "$dst"
