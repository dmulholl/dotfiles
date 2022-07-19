#!/usr/bin/env bash
set -eo pipefail

if test -z "$BORG_REPO"; then
    echo "Error: the BORG_REPO environment variable must be set."
    exit 1
fi

if test -z "$BORG_PASSPHRASE"; then
    echo "Error: the BORG_PASSPHRASE environment variable must be set."
    exit 1
fi

# Uncomment this line for the first run to create a new repository.
# borg init --encryption=repokey $BORG_REPO

termtitle green "Borg: ${HOME} --> ${BORG_REPO}"

borg create --stats ::'{user}-{utcnow}' \
    ~/Books                             \
    ~/Documents                         \
    ~/Pictures                          \
    ~/dev                               \
    ~/.config                           \
    ~/.dotfiles                         \
    ~/.gnupg                            \
    ~/.ssh                              \
    ~/.aws                              \
    ~/.env                              \
    ~/.vscode                           \
    ~/.gitconfig_local                  \
    --exclude '*.pyc'                   \
    --exclude '*/__pycache__'           \
    --exclude '*.Spotlight*'            \
    --exclude '*.fseventd'              \
    --exclude '*.fseventsd'             \
    --exclude '*.DS_Store'              \
    --exclude '*.localized'             \
    --exclude '~/dev/tmp'               \
    --exclude '~/dev/go'                \
    --exclude '~/.config/borg'

borg prune --keep-daily 7 --keep-weekly 4 --keep-monthly 12
