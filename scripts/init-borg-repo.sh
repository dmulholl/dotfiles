#!/usr/bin/env bash
set -euo pipefail

source $HOME/.dotlocal/env/borg.sh

if test ! -v BORG_REPO; then
    echo "error: missing environment variable BORG_REPO"
    exit 1
fi

borg init --encryption=repokey $BORG_REPO
