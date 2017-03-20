# --------------------------------------------------------------------------
# Set the PATH environment variable.
# --------------------------------------------------------------------------

# Store a copy of the default path.
if [[ -z "$SYSPATH" ]]; then
    SYSPATH=$PATH
    export SYSPATH
fi

# Start with the dotfiles binaries.
PATH=$DOTFILES/bin

# $HOME binaries.
if [[ -d "$HOME/bin" ]]; then
    PATH=$PATH:$HOME/bin
fi

# Development binaries.
if [[ -d "$HOME/dev/bin" ]]; then
    PATH=$PATH:$HOME/dev/bin
fi

# Homebrew binaries on OSX.
if [[ -d "$HOME/.homebrew/bin" ]]; then
    PATH=$PATH:$HOME/.homebrew/bin
fi

# Locally installed binaries.
PATH=$PATH:/usr/local/bin

# System binaries.
PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin

# Add the default system path back on at the end.
PATH=$PATH:$SYSPATH

# Remove any duplicate entries.
PATH="$(echo $PATH | perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, scalar <>))')"

# Make it so.
export PATH
