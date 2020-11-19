# ------------------------------------------------------------------------------
# Set the PATH environment variable.
# ------------------------------------------------------------------------------

# Store a copy of the default path.
if test -z "$DOTSYSPATH"; then
    export DOTSYSPATH=$PATH
fi

# Start with the dotfiles binaries.
PATH=~/.dotfiles/bin

# $HOME binaries.
if test -d "$HOME/bin"; then
    PATH="$PATH:$HOME/bin"
fi

# Dev binaries.
if test -d "$HOME/dev/bin"; then
    PATH="$PATH:$HOME/dev/bin"
fi

# Go binaries.
if test -d "$HOME/dev/go/bin"; then
    PATH="$PATH:$HOME/dev/go/bin"
fi

# Rust binaries.
if test -d "$HOME/.cargo/bin"; then
    PATH="$PATH:$HOME/.cargo/bin"
fi

# Macports binaries.
if test -d "/opt/local/bin"; then
    PATH="$PATH:/opt/local/bin:/opt/local/sbin"
fi

# Locally binaries.
PATH="$PATH:/usr/local/bin"

# System binaries.
PATH="$PATH:/usr/bin:/bin:/usr/sbin:/sbin"

# Add the default system path back on at the end.
PATH=$PATH:$DOTSYSPATH

# Remove any duplicate entries.
PATH="$(echo $PATH | perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, scalar <>))')"

# Make it so.
export PATH
