#!/usr/bin/env bash
set -eo pipefail

if test "$#" != "1"; then
    echo "Error: expected 1 argument (the backup disk name), found $#."
    exit 1
fi

disk_name="$1"
termtitle green "Rsync: ${HOME} --> ${disk_name}:${backup_name}"

backup_name=$(hostname -s | tr '[:upper:]' '[:lower:]')
if test -n "$DOT_BACKUP_NAME"; then
    backup_name="$DOT_BACKUP_NAME"
fi

# The slash at the end means copy the contents of the directory.
src="${HOME}/"

# A slash at the end can cause problems when copying to the root of a drive.
dst="/Volumes/${disk_name}/Backups/${backup_name}"

if test ! -d $dst; then
    echo "Error: cannot locate $dst."
    exit 1
fi

# Increase the maximum number of files the process can have open.
ulimit -n 4096

# Run rsync in mirroring mode.
rsync -av --delete                          \
    --exclude ".DS_Store"                   \
    --exclude ".Spotlight*"                 \
    --exclude ".fseventd"                   \
    --exclude ".fseventsd"                  \
    --exclude ".localized"                  \
    --exclude "__pycache__"                 \
    --exclude "/.Trashes"                   \
    --exclude "/.[Tt]rash"                  \
    --exclude "/.cache"                     \
    --exclude "/.dotpyenvs"                 \
    --exclude "/.cargo"                     \
    --exclude "/.swiftpm"                   \
    --exclude "/dev/tmp"                    \
    --exclude "/dev/go"                     \
    --exclude '/dev/*/maps/raw'             \
    --exclude "/Library"                    \
    --exclude "/Downloads"                  \
    --exclude "/Applications"               \
    --exclude "/VMs"                        \
    --exclude "/Virtual Machines"           \
    -- "$src" "$dst"
