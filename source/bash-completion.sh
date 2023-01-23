# ------------------------------------------------------------------------------
# Bash completion.
# ------------------------------------------------------------------------------

# Git-completion -- Homebrew on Apple silicon
if [ -f /opt/homebrew/etc/bash_completion.d/git-completion.bash ]; then
    . /opt/homebrew/etc/bash_completion.d/git-completion.bash
fi

# Git-completion -- Homebrew on Apple Intel.
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    . /usr/local/etc/bash_completion.d/git-completion.bash
fi

