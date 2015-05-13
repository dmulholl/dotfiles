
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
