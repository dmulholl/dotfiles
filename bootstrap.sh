# ------------------------------------------------------------------------------
# This bootstrap file gets sourced whenever a new shell instance is initialized.
# ------------------------------------------------------------------------------

# Only run this file once per shell instance.
if test -n "$dot_booted"; then
    return
fi
dot_booted="true"

# Load the `dot` command.
source ~/.dotfiles/dot.sh

# Source all files in the .dotfiles/source/ directory.
dot_source

# Try to activate the default Python virtual environment if it's available.
dotpy_try_activate base
