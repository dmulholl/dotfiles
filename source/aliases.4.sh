# --------------------------------------------------------------------------
# Aliases
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

# History.
alias h="history"
alias hist="history 25"

# Git.
alias ga="git add"
alias gc="git commit"
alias gd="git diff"
alias gl="git log --oneline --graph"
alias gs="git status --short --branch"
alias gcm="git commit -m"

# Hosts file.
alias hosts="edit /etc/hosts"

# Determine which variety of `ls` we're using.
if is_osx; then
    colorflag="-G"
else
    colorflag="--color"
fi

# Add colour support and variants to `ls`.
alias ls="ls ${colorflag}"
alias la="ls -a ${colorflag}"
alias ll="ls -al ${colorflag}"

# Show/hide files in OSX Finder.
alias show="defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder /System/Library/CoreServices/Finder.app"
alias hide="defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder /System/Library/CoreServices/Finder.app"

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
