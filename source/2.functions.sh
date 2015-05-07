
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

# Run the dotfiles script, then (re)source all the repository's source files.
function dotfiles() {
    $DOTFILES/bin/dotfiles "$@" && src
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
