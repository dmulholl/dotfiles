# --------------------------------------------------------------------------
# Set the PATH environment variable.
# --------------------------------------------------------------------------

# Store a copy of the default path.
if test -z "$DOTSYSPATH"; then
    export DOTSYSPATH=$PATH
fi

# Start with the dotfiles binaries.
PATH=$DOTFILES/bin

# $HOME binaries.
if test -d "$HOME/bin"; then
    PATH=$PATH:$HOME/bin
fi

# Development binaries.
if test -d "$HOME/dev/bin"; then
    PATH=$PATH:$HOME/dev/bin
fi

# Homebrew binaries on OSX.
if test -d "$HOME/.homebrew/bin"; then
    PATH=$PATH:$HOME/.homebrew/bin
fi

# Locally installed binaries.
PATH=$PATH:/usr/local/bin

# System binaries.
PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin

# Add the default system path back on at the end.
PATH=$PATH:$DOTSYSPATH

# Remove any duplicate entries.
PATH="$(echo $PATH | perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, scalar <>))')"

# Make it so.
export PATH
