
# ----------------------------------------------------------------------------
# Dotfiles (re)initialization script
# ----------------------------------------------------------------------------

# Location of the dotfiles repository.
export DOTFILES=~/.dotfiles

# Delete any pesky .DS_Store files that may have sneaked into the repository.
find $DOTFILES -name ".DS_Store" -delete

# We want globbing to match on files beginning with a dot.
shopt -s dotglob
shopt -s nullglob

# Source all files in the repository's /source directory.
for srcfile in $DOTFILES/source/*.sh; do
    source "$srcfile"
done

# Create symbolic links to all files in the repository's /link directory.
e_title "Linking files into ~"
for lnkfile in $DOTFILES/link/*; do
    ln -sf "$lnkfile" ~/ && e_check "Linking: ~/$(basename $lnkfile)"
done

# Set OS-specific defaults.
e_title "Setting OS defaults"
is_osx && e_arrow "OSX detected" && source $DOTFILES/os/osx.sh
is_linux && e_arrow "Linux detected"
is_bsd && e_arrow "BSD detected"
is_msys && e_arrow "MSys detected"
is_cygwin && e_arrow "Cygwin detected"

# Make sure we return a successful exit code.
true
