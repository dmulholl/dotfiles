
# ----------------------------------------------------------------------------
# Dotfiles (re)initialization script
# ----------------------------------------------------------------------------

# Location of the dotfiles repository.
export DOTFILES=~/.dotfiles

# Delete any pesky .DS_Store files that may have sneaked into the repository.
find $DOTFILES -name ".DS_Store" -delete

# Source all files in the repository's /source directory.
for srcfile in $DOTFILES/source/*.sh; do
    source "$srcfile"
done

# Create symbolic links to all files in the repository's /link directory.
e_title "Linking files into ~"
for srcfile in $DOTFILES/link/*; do
    target=.$(basename $srcfile)
    ln -sf "$srcfile" ~/$target && e_check "Linking: ~/$target"
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
