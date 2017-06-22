# --------------------------------------------------------------------------
# Shell aliases.
# --------------------------------------------------------------------------

# Navigation.
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"

# Misc.
alias t="trash"
alias i="ironclad"
alias l="mac lock"

# Editor.
alias atom="atom -a"
alias a="atom -a"

# History.
alias h="history"
alias h5="history 5"
alias h10="history 10"

# Git.
alias ga="git add"
alias gaa="git add --all"

alias gc="git commit"

alias gcah="git commit -am Housekeeping"
alias gcahp="git commit -am Housekeeping && git push"

alias gcad="git commit -am 'Update documentation'"
alias gcadp="git commit -am 'Update documentation'"

alias gcm="git commit -m"
alias gcam="git commit -am"

alias gcar="git commit -am 'Update readme'"
alias gcarp="git commit -am 'Update readme' && git push"

alias gd="git diff"

alias gl="git log --oneline --graph"
alias gl5="git log --oneline --graph -5"
alias gl10="git log --oneline --graph -10"

alias gp="git push"

alias gs="git status --short --branch"

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

# Local development versions.
alias arkd="python3 ~/src/ark/ark"
alias ivyd="python3 ~/src/ivy/ivy"
alias maltd="python3 ~/src/malt/malt"
