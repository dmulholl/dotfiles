# --------------------------------------------------------------------------
# Functions
# --------------------------------------------------------------------------

# Set the window title.
function title() {
    if [[ -n "$1" ]]; then
        echo -n -e "\033]0;$1\007"
    else
        echo -n -e "\033]0;${USER}@${HOSTNAME}\007"
    fi
}

# Python makes a nice command line calculator.
function calc() {
    python3 -c "from math import *; print($*)"
}

# Are we running on a Mac?
function is_osx() {
    [[ "$OSTYPE" =~ ^darwin ]]
}

# Are we running on a Linux box?
function is_linux() {
    [[ "$OSTYPE" =~ ^linux ]]
}

# Are we running on a BSD box?
function is_bsd() {
    [[ "$OSTYPE" =~ ^bsd ]]
}

# Are we running on MSys on Windows?
function is_msys() {
    [[ "$OSTYPE" =~ ^msys ]]
}

# Are we running on Cygwin on Windows?
function is_cygwin() {
    [[ "$OSTYPE" =~ ^cygwin ]]
}

# Test if a binary is installed on the system.
function is_installed() {
    if type $1 &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# Make a directory and cd into it in one step.
function mkcd() {
    if [[ -n "$1" ]]; then
        mkdir -p "$1"
        cd "$1"
    fi
}

# Unicommand for the clipboard on OSX.
function clip() {
    [ -t 0 ] && pbpaste || pbcopy
}

# Clean build artifacts from the current directory.
function clean() {
    rm -rf *.egg-info
    rm -rf dist
    rm -rf *.pyc
    rm -rf __pycache__
}
