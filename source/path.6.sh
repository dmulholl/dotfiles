# --------------------------------------------------------------------------
# Path
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

# Locally compiled Go binaries.
if [[ -n "$GOPATH" ]] && [[ "$GOPATH" != "$HOME/dev" ]]; then
    PATH=$PATH:$GOPATH/bin
fi

# Go installation binaries.
if [[ -n "$GOROOT" ]]; then
    PATH=$PATH:$GOROOT/bin
fi

# Homebrew binaries on OSX.
if [[ -d "$HOME/.brew/bin" ]]; then
    PATH=$PATH:$HOME/.brew/bin
fi

# Locally installed binaries.
PATH=$PATH:/usr/local/bin

# System binaries.
PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin

# Add the default system path back on at the end.
PATH=$PATH:$SYSPATH

# Make it so.
export PATH
