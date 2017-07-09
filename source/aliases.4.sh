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
alias atom="atom -a"
alias ydl="youtube-dl"

# History.
alias h="history"
alias h1="history 10"
alias h2="history 20"
alias h3="history 30"
alias h4="history 40"
alias h5="history 50"
alias h6="history 60"
alias h7="history 70"
alias h8="history 80"
alias h9="history 90"

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
alias gl1="git log --oneline --graph -10"
alias gl2="git log --oneline --graph -20"
alias gl3="git log --oneline --graph -30"
alias gl4="git log --oneline --graph -40"
alias gl5="git log --oneline --graph -50"
alias gl6="git log --oneline --graph -60"
alias gl7="git log --oneline --graph -70"
alias gl8="git log --oneline --graph -80"
alias gl9="git log --oneline --graph -90"

alias gp="git push"

alias gs="git status --short --branch"

# Hosts file.
alias hosts="sudo vim /etc/hosts"

# Determine which variety of `ls` we're using.
if is_mac; then
    lsflags="-F"
else
    lsflags="--color"
fi

# Add colour support and variants to `ls`.
alias la="ls ${lsflags} -a"
alias ll="ls ${lsflags} -l"
alias lla="ls ${lsflags} -la"
alias lal="ls ${lsflags} -la"
alias ls="ls ${lsflags}"

# Reload the shell.
alias reload="exec $SHELL -l"

# Python unit tests.
alias pytest="py.test"

# Tree.
alias t2="tree -L 2"
alias t3="tree -L 3"
alias t4="tree -L 4"
alias t5="tree -L 5"

# Calendar. (Install gcal as it has lots more options.)
alias cal="gcal --starting-day=1"

# Default to GnuPG v2.
alias gpg="gpg2"

# Local development versions.
alias arkd="python3 ~/src/ark/ark"
alias ivyd="python3 ~/src/ivy/ivy"
alias maltd="python3 ~/src/malt/malt"
