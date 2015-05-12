
# ----------------------------------------------------------------------------
# Dotfiles (re)initialization script
# ----------------------------------------------------------------------------

# Location of the dotfiles repository.
export DOTFILES=~/.dotfiles

# Set a flag to indicate that we're (re)initializing the installation.
dotinit="on"

# Set our backup directory, in case we need it.
dotbackups="$DOTFILES/backups/$(date "+%Y-%m-%d-%H-%M-%S")/"

# Load our bootstrapping functions.
source $DOTFILES/dotfuncs.sh

# Source all files in the repository's /source directory.
src --verbose

# Delete any pesky .DS_Store files that may have sneaked into the repository.
find $DOTFILES -name ".DS_Store" -delete

# Create symbolic links to all files in the repository's /link directory.
e_title "Linking files into ~/"
for srcfile in $DOTFILES/link/*; do
    trgfile=~/.$(basename $srcfile)
    e_arrow "Linking: ~/$(basename $trgfile)"
    [[ -e $trgfile ]] && [[ ! -h $trgfile ]] && dotfiles_backup $trgfile
    ln -sf $srcfile $trgfile
done

# Set OS-specific defaults.
e_title "Setting OS defaults"
is_osx && e_arrow "OSX detected" && source $DOTFILES/os/osx.sh
is_linux && e_arrow "Linux detected"
is_bsd && e_arrow "BSD detected"
is_msys && e_arrow "MSys detected"
is_cygwin && e_arrow "Cygwin detected"

# Unset our initialization flag.
unset dotinit

# Make sure we return a successful exit code.
true
