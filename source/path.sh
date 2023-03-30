# ------------------------------------------------------------------------------
# Set the PATH environment variable.
# ------------------------------------------------------------------------------

# Store a copy of the default path.
if test -z "$DEFAULT_PATH"; then
    export DEFAULT_PATH=$PATH
fi

# Start with the dotfiles binaries.
PATH="$HOME/.dotfiles/bin"

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

# Python 3.11 installed from python.org.
if test -d "/Library/Frameworks/Python.framework/Versions/3.11/bin"; then
    PATH="$PATH:/Library/Frameworks/Python.framework/Versions/3.11/bin"
fi

# Macports binaries.
if test -d "/opt/local/bin"; then
    PATH="$PATH:/opt/local/bin:/opt/local/sbin"
fi

# Homebrew binaries on Apple silicon.
if test -d "/opt/homebrew/bin"; then
    PATH="$PATH:/opt/homebrew/bin"
fi

# Add the default system path back on at the end.
PATH="$PATH:$DEFAULT_PATH"

# Make it so.
export PATH
