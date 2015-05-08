
# ----------------------------------------------------------------------------
# Functions
# ----------------------------------------------------------------------------

# Logging functions.
function e_title() { echo -e "\n${bold}$@${normal}"; }
function e_check() { echo -e " ${green}✔${normal}  $@"; }
function e_error() { echo -e " ${red}✖${normal}  $@"; }
function e_arrow() { echo -e " ${blue}➜${normal}  $@"; }

# Source all files in the repository's /source directory.
function src() {
    local file
    for file in $DOTFILES/source/*.sh; do
        source "$file"
    done
}

# Update the dotfiles repository.
function dotfiles_update() {
    e_title "Checking for updates..."
    cd $DOTFILES
    local prev_head="$(git rev-parse HEAD)"
    # git pull
    if [[ "$(git rev-parse HEAD)" != "$prev_head" ]]; then
        e_check "Dotfiles repository updated"
    else
        e_arrow "No updates found"
    fi
}

# Print the help text for the dotfiles command.
function dotfiles_help() {
    cat <<TEXT
Usage: dotfiles

  Reinitialization command for the dotfiles installation.
  See the readme for details:

  https://github.com/dmulholland/dotfiles
TEXT
}

# Reinitialize the dotfiles installation.
function dotfiles() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        dotfiles_help
    else
        dotfiles_update
        source $DOTFILES/init.sh
    fi
}

# Set the window title.
function title() {
    echo -n -e "\033]0;$1\007"
}

# Python makes a nice command line calculator.
function calc() {
    python3 -c "from math import *; print($*)"
}

# Are we running on a Mac?
function is_osx() {
    [[ "$OSTYPE" =~ ^darwin ]] || return 1
}

# Are we running on a Linux box?
function is_linux() {
    [[ "$OSTYPE" =~ ^linux ]] || return 1
}

# Are we running on a BSD box?
function is_bsd() {
    [[ "$OSTYPE" =~ ^bsd ]] || return 1
}

# Are we running on MSys on Windows?
function is_msys() {
    [[ "$OSTYPE" =~ ^msys ]] || return 1
}

# Are we running on Cygwin on Windows?
function is_cygwin() {
    [[ "$OSTYPE" =~ ^cygwin ]] || return 1
}
