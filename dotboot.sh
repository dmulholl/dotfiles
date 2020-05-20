# ------------------------------------------------------------------------------
# Bootstrap file - this file gets sourced whenever a new shell instance is 
# initialized. 
# ------------------------------------------------------------------------------

# We only want to run this file once per shell instance.
if test -n "$dotbootstrapped"; then
    return
fi
dotbootstrapped="true"

# Load the `dot` command.
source ~/.dotfiles/dotfuncs.sh

# Source all files in the installation's /source directory.
dot src

# Try to activate the default Python virtual environment if it's available.
dotpy-try-activate base
