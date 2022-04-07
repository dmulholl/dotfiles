#!/usr/bin/env bash
set -euo pipefail

# Make sure we have a single argument.
if test "$#" = "0"; then
    echo "Error: too few arguments, a disk name is required."
    exit 1
elif test "$#" != "1"; then
    echo "Error: too many arguments, expected 1."
    exit 1
fi

# The argument specifies the name of the destination disk.
disk_name="$1"
termtitle red "Backing up all files from ${HOME} to ${disk_name} using rsync."

# Get the lowercased hostname of the computer.
host_name=$(hostname -s | tr '[:upper:]' '[:lower:]')

# The slash at the end of the source directory path is important. It means
# copy the *contents* of the directory.
src="${HOME}/"

# A slash at the end of the destination path can cause problems when copying
# to the root of a drive.
dst="/Volumes/${disk_name}/backups/${host_name}"

# Check the destination directory exists.
if test ! -d $dst; then
    echo "Error: cannot locate $dst."
    exit 1
fi

# Reset the maximum number of files that the application can have open.
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
    --exclude "/.pyenvs"                    \
    --exclude "/.cargo"                     \
    --exclude "/.swiftpm"                   \
    --exclude "/dev/tmp"                    \
    --exclude "/dev/go"                     \
    --exclude "/Library"                    \
    --exclude "/Torrents"                   \
    --exclude "/Applications"               \
    --exclude "/VMs"                        \
    --exclude "/Virtual Machines"           \
    -- "$src" "$dst"