# -------------------------------------------------------------------------
# Bootstrap file for the dotfiles installation.
#
# This file should load whenever a new shell instance is initialized.
# -------------------------------------------------------------------------

# We only want to run this file once per shell instance.
if test -n "$dotbootstrapped"; then
    return
fi
dotbootstrapped="true"

# Location of the dotfiles installation.
export DOTFILES=~/.dotfiles

# Load the installation's admin functions.
source $DOTFILES/funcs.sh

# Source all files in the installation's /source directory.
dot src

# Try to activate the default Python virtual environment if it's available.
dotpy-try-activate py3
