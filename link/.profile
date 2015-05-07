
# ----------------------------------------------------------------------------
# Bootstrap file for the dotfiles repository
# ----------------------------------------------------------------------------

# Location of the dotfiles repository.
export DOTFILES=~/.dotfiles

# Source all files in the repository's /source directory.
for srcfile in $DOTFILES/source/*.sh; do
    source "$srcfile"
done
