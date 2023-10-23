# ------------------------------------------------------------------------------
# Shell aliases.
# ------------------------------------------------------------------------------

# Navigation.
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"

# Make.
alias mc="make check"
alias md="make debug"
alias mr="make release"
alias mcd="make check-debug"
alias mcr="make check-release"
alias mcs="make check-sanitize"

# Applications.
alias vv="vim"
alias arkd="python3 $HOME/dev/src/ark/ark"
alias hb="hexbomb"
alias irn="ironclad"
alias int="intspector"
alias vimvd="$HOME/dev/src/vimv/target/debug/vimv"
alias ca="code -a"

# Commands.
alias dir="open ."
alias dush="du -sh"
alias pypi="./setup.py sdist bdist_wheel && twine upload dist/* && clean python"
alias hosts="sudo vim /etc/hosts"
alias ytdlv="yt-dlp -f mp4"
alias ytdlp="yt-dlp -f mp4 -o '%(playlist_index)02d. %(title)s.%(ext)s'"

# Pyro.
alias pd="$HOME/dev/src/pyro/build/debug/pyro"
alias pdt="$HOME/dev/src/pyro/build/debug/pyro test"
alias pdtv="$HOME/dev/src/pyro/build/debug/pyro test -v"
alias pdta="$HOME/dev/src/pyro/build/debug/pyro test $HOME/dev/src/pyro/tests/*.pyro"
alias pdtav="$HOME/dev/src/pyro/build/debug/pyro test -v $HOME/dev/src/pyro/tests/*.pyro"
alias pr="$HOME/dev/src/pyro/build/release/pyro"
alias prt="$HOME/dev/src/pyro/build/release/pyro test"
alias prtv="$HOME/dev/src/pyro/build/release/pyro test -v"
alias prta="$HOME/dev/src/pyro/build/release/pyro test $HOME/dev/src/pyro/tests/*.pyro"
alias prtav="$HOME/dev/src/pyro/build/release/pyro test -v $HOME/dev/src/pyro/tests/*.pyro"

# History: 'hn' loads new history entries from other terminal windows.
alias hh="history 25"
alias hhh="history 45"
alias hn="history -a; history -n"
alias hl="history -a; history -n"

# Git.
alias ga="git add"
alias gaa="git add --all"
alias gp="git push"
alias gpt="git push && git push --tags"
alias gd="git diff"
alias gds="git diff --staged"
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

alias gcodap="git checkout develop && git pull"
alias gcosap="git checkout staging && git pull"
alias gcomap="git checkout master && git pull"

# Listings.
alias ls="ls -F"
alias ls1="ls -F1"
alias la="ls -FA"
alias la1="ls -FA1"
alias ll="ls -Flh"
alias lla="ls -FlhA"

# Tree.
alias tt="tree -F"
alias t2="tree -F -L 2"
alias t3="tree -F -L 3"
alias t4="tree -F -L 4"
alias t5="tree -F -L 5"
alias tta="tree -F -a"
alias tts="tree -F -h"
alias ttas="tree -F -a -h"

# Sudo: preserve the existing shell environment; same as -E.
alias sudo="sudo --preserve-env"

# Browsers.
alias chrome="open -a 'Google Chrome'"
alias safari="open -a Safari"
