
# ----------------------------------------------------------------------------
# Functions
# ----------------------------------------------------------------------------

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
