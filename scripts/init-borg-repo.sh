#!/usr/bin/env bash
set -euo pipefail

source $HOME/.dotlocal/env/borg.sh

borg init --encryption=repokey $BORG_REPO
