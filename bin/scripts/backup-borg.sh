#!/usr/bin/env bash
set -eo pipefail

source $HOME/.env/borg.sh

# Run the script with the --init flag to create a new repository.
# This only needs to be done once.
if [[ "$1" == "--init"  ]]; then
    borg init --encryption=repokey $BORG_REPO
fi

termtitle green "Borg: ${HOME} --> ${BORG_REPO}"

borg create --stats ::'{user}-{utcnow}' \
    ~/Books                             \
    ~/Documents                         \
    ~/Pictures                          \
    ~/dev                               \
    ~/.config                           \
    ~/.dotfiles                         \
    ~/.dotlocal                         \
    ~/.gnupg                            \
    ~/.ssh                              \
    ~/.aws                              \
    ~/.env                              \
    ~/.vscode                           \
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
