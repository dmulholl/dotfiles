# --------------------------------------------------------------------------
# Shell aliases.
# --------------------------------------------------------------------------

# Navigation.
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"

# Trash.
alias t="trash"

# Editor.
alias e="edit"
alias atom="atom -a"
alias a="atom -a"

# History.
alias h="history"
alias hist="history 25"

# Git.
alias ga="git add"
alias gc="git commit"
alias gd="git diff"
alias gl="git log --oneline --graph"
alias gs="git status --short --branch"
alias push="git push"
alias commit="git commit"

# Hosts file.
alias hosts="sudo vim /etc/hosts"

# Determine which variety of `ls` we're using.
if is_mac; then
    colorflag="-G"
else
    colorflag="--color"
fi

# Add colour support and variants to `ls`.
alias ls="ls ${colorflag}"
alias la="ls -a ${colorflag}"
alias ll="ls -al ${colorflag}"

# Reload the shell.
alias reload="exec $SHELL -l"

# Help remembering `ln` argument order, because `man ln` is useless.
alias lnh="echo ln -sv link-points-to-here link-lives-here"

# Python unit tests.
alias pytest="py.test"

# Tree.
alias t2="tree -L 2"
alias t3="tree -L 3"

# Calendar. (Install gcal as it has lots more options.)
alias cal="gcal --starting-day=1"

# Default to GnuPG v2.
alias gpg="gpg2"

# Command for managing Python virtual environments.
alias py="pv"

# Ark development version.
alias dark="python3 ~/dev/src/ark/ark"
alias ivy="python3 ~/dev/src/ivy/ivy"

