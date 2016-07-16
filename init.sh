# --------------------------------------------------------------------------
# Dotfiles initialization script.
# --------------------------------------------------------------------------

# Location of the dotfiles installation.
export DOTFILES=~/.dotfiles

# Load our bootstrapping functions.
source $DOTFILES/dotfuncs.sh

# Initialize the installation.
dot init

# Activate the default Python 3 virtual enivronment if available.
pv-try-activate py3
