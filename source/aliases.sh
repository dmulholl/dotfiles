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
alias e="vim"

# Doubles.
alias ff="fzf"
alias vi="vim"
alias vv="vim"
alias iv="python3 ~/dev/src/ivy/ivy"
alias md="make debug"
alias mc="make check"
alias pd="~/dev/src/pyro/out/debug/pyro"
alias pr="~/dev/src/pyro/out/release/pyro"
alias pt="~/dev/src/pyro/out/debug/pyro test ~/dev/src/pyro/tests/*.pyro"
alias nn="vim ~/dev/notes/notes.txt"

# Triples.
alias irn="ironclad"
alias dir="open ."
alias cal="gcal --starting-day=1"
alias int="intspector"
alias ptv="~/dev/src/pyro/out/debug/pyro test -v ~/dev/src/pyro/tests/*.pyro"
alias ddx="deploydocs"

# Quads.
alias dush="du -sh"
alias atom="atom -a"
alias code="code -a"
alias pyup="./setup.py sdist bdist_wheel && twine upload dist/* && clean python"

# Quints.
alias vimvd="~/dev/src/vimv/target/debug/vimv"
alias hosts="sudo vim /etc/hosts"
alias ytdlv="yt-dlp -f mp4"
alias ytdlp="yt-dlp -f mp4 -o '%(playlist_index)02d. %(title)s.%(ext)s'"

# History: 'hn' loads new history entries from other terminal windows.
alias hh="history 25"
alias hhh="history 45"
alias hn="history -a; history -n"

# Git.
alias ga="git add"
alias gaa="git add --all"
alias gp="git push"
alias gpt="git push && git push --tags"
alias gd="git diff"
alias gs="git status --short --branch"
alias gb="git branch"
alias gco="git checkout"

alias gc="git commit"
alias gcm="git commit -m"
alias gcam="git commit -am"
alias gcah="git commit -am Housekeeping"
alias gcad="git commit -am 'Update documentation'"
alias gcar="git commit -am 'Update readme'"
alias gcas="git commit -am Snapshot"

alias gl="git log --oneline --graph -25"
alias gll="git log --oneline --graph -45"

# Directory listings.
alias ls="ls -F"
alias la="ls -Fa"
alias ll="ls -Flh"
alias lla="ls -Flha"
alias lal="ls -Falh"

# Tree.
alias tt="tree -F"
alias t2="tree -F -L 2"
alias t3="tree -F -L 3"
alias t4="tree -F -L 4"
alias t5="tree -F -L 5"
alias tts="tree -F -h"

# Jumps.
alias jb="j bin"
alias jd="j dev"
alias jn="j notes"
alias js="j src"
alias jt="j tmp"
alias jv="j vay"

# Sudo: preserve the existing shell environment; same as -E.
alias sudo="sudo --preserve-env"
