# --------------------------------------------------------------------------
# Path
# --------------------------------------------------------------------------

# Dotfiles binaries.
PATH=$DOTFILES/bin

# Development binaries.
PATH=$PATH:~/dev/bin

# $HOME binaies.
if [[ -d "$HOME/bin" ]]; then
    PATH=$PATH:$HOME/bin
fi

# Go binaries.
if [[ -n "$GOPATH" ]]; then
    PATH=$PATH:$GOPATH/bin
    PATH=$PATH:$GOROOT/bin
fi

# Locally installed binaries.
PATH=$PATH:/usr/local/bin

# System binaries.
PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin

# Make it so.
export PATH
