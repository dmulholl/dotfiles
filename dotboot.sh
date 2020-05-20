# ------------------------------------------------------------------------------
# This bootstrap file gets sourced whenever a new shell instance is initialized.
# ------------------------------------------------------------------------------

# Only run this file once per shell instance.
if test -n "$dotbooted"; then
    return
fi
dotbooted="true"

# Load the `dot` command.
source ~/.dotfiles/dotfuncs.sh

# Source all files in the /source directory.
dot src

# Try to activate the default Python virtual environment if it's available.
dotpy-try-activate base
