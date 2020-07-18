# ------------------------------------------------------------------------------
# Shell aliases.
# ------------------------------------------------------------------------------

# Navigation.
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"

# Singles.
alias v="vim"

# Doubles.
alias ff="fzf"
alias dd="deploydocs"
alias iv="python3 ~/dev/src/ivy/ivy"

# Triples.
alias ydl="youtube-dl"
alias irn="ironclad"
alias lck="mac lock"
alias slp="mac sleep"
alias dir="open ."
alias cal="gcal --starting-day=1"
alias int="intspector"

# History.
alias h1="history 10"
alias h2="history 20"
alias h3="history 30"
alias h4="history 40"
alias h5="history 50"
alias h6="history 60"
alias h7="history 70"
alias h8="history 80"
alias h9="history 90"
alias hh="history 25"

# Git.
alias ga="git add"
alias gaa="git add --all"

alias gp="git push"
alias gpt="git push --tags"
alias gd="git diff --color | diff-so-fancy | less --tabs=4 -RFX"
alias gs="git status --short --branch"

alias gc="git commit"
alias gcm="git commit -m"
alias gcam="git commit -am"
alias gcah="git commit -am Housekeeping"
alias gcad="git commit -am 'Update documentation'"
alias gcar="git commit -am 'Update readme'"
alias gcas="git commit -am Snapshot"

alias gl="git log --oneline --graph -25"
alias gl1="git log --oneline --graph -10"
alias gl2="git log --oneline --graph -20"
alias gl3="git log --oneline --graph -30"
alias gl4="git log --oneline --graph -40"
alias gl5="git log --oneline --graph -50"
alias gl6="git log --oneline --graph -60"
alias gl7="git log --oneline --graph -70"
alias gl8="git log --oneline --graph -80"
alias gl9="git log --oneline --graph -90"

alias gco="git checkout"

# Vim.
alias hosts="sudo vim /etc/hosts"
alias notes="cd ~/dev/etc/notes && vim"

# Directory listings.
alias la="ls -Fa"
alias lal="ls -Falh"
alias ll="ls -Flh"
alias lla="ls -Flha"
alias ls="ls -F"
alias dush="du -sh"

# Reload the shell.
alias reload="exec $SHELL -l"

# Python unit tests.
alias pytest="py.test"

# Tree.
alias tt="tree -F"
alias t2="tree -F -L 2"
alias t3="tree -F -L 3"
alias t4="tree -F -L 4"
alias t5="tree -F -L 5"

# Editor.
alias atom="atom -a"
alias code="code -a"
