# ------------------------------------------------------------------------------
# Shell functions.
# ------------------------------------------------------------------------------

# Set the window title.
function title() {
    if test -n "$1"; then
        echo -n -e "\e]0;$1\007"
    fi
}

# Python makes a nice command line calculator.
function pycalc() {
    python3 -c "from math import *; print($*)"
}

# Are we running on a Mac?
function is_mac() {
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
    if test -n "$1"; then
        mkdir -p "$1"
        cd "$1"
    fi
}

# Unicommand for the clipboard on OSX.
function clip() {
    test -t 0 && pbpaste || pbcopy
}

# Clean build artifacts from the current directory.
function clean() {
    find . -name ".DS_Store" -delete
    find . -name "._.DS_Store" -delete
    find . -name "._*" -delete
    find . -name ".*.swp" -delete

    if test "$1" == "python" || test "$1" == "all"; then
        find . -name "*.egg-info" -exec rm -r "{}" +
        find . -name "__pycache__" -exec rm -r "{}" +
        find . -name ".pytest_cache" -exec rm -r "{}" +
        find . -name "*.pyc" -delete
        find . -name "dist" -exec rm -r "{}" +
        find . -name "build" -exec rm -r "{}" +
    fi

    if test "$1" == "latex" || test "$1" == "all"; then
        find . -name "*.aux" -delete
        find . -name "*.toc" -delete
        find . -name "*.out" -delete
        find . -name "*.lof" -delete
        find . -name "*.log" -delete
        find . -name "*.lot" -delete
        find . -name "*.dvi" -delete
        find . -name "*.fls" -delete
        find . -name "*.xdv" -delete
        find . -name "*.fdb_latexmk" -delete
        find . -name "*.bbl" -delete
        find . -name "*.blg" -delete
    fi
}

# Colourized man pages.
function man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

# Interactive mv command for renaming files.
function mv() {
    if [ "$#" -ne 1 ]; then
        command mv "$@"
        return
    fi
    if [ ! -f "$1" ]; then
        command file "$@"
        return
    fi
    read -ei "$1" newfilename
    mv -v "$1" "$newfilename"
}

# Request user confirmation. First argument is used as the prompt string.
function confirm() {
    local input
    while true; do
        echo -n -e " \e[1;35m?\e[0m  $@ (y/n) "
        read input
        case $input in
            [Yy]*)
                return 0;;
            *)
                return 1;;
        esac
    done
}
