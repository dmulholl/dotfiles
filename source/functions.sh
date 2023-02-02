# ------------------------------------------------------------------------------
# Shell functions.
# ------------------------------------------------------------------------------

# Set the window title.
title() {
    if test -n "$1"; then
        echo -n -e "\e]0;$1\007"
    fi
}

# Python makes a nice command line calculator.
pycalc() {
    python3 -c "from math import *; print($*)"
}

# Are we running on a Mac?
is_mac() {
    [[ "$OSTYPE" =~ ^darwin ]]
}

# Are we running on a Linux box?
is_linux() {
    [[ "$OSTYPE" =~ ^linux ]]
}

# Are we running on a BSD box?
is_bsd() {
    [[ "$OSTYPE" =~ ^bsd ]]
}

# Are we running on MSys on Windows?
is_msys() {
    [[ "$OSTYPE" =~ ^msys ]]
}

# Are we running on Cygwin on Windows?
is_cygwin() {
    [[ "$OSTYPE" =~ ^cygwin ]]
}

# Test if an executable, alias, or function is available on PATH.
is_available() {
    if type $1 &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# Test if an executable script or binary is available on PATH.
is_executable() {
    if which "$1" &> /dev/null; then
        if [[ -x "$(which "$1")" ]]; then
            return 0
        fi
        return 1
    else
        return 1
    fi
}

# Make a directory and cd into it in one step.
mkcd() {
    if test -n "$1"; then
        mkdir -p "$1"
        cd "$1"
    fi
}

# Unicommand for the clipboard on OSX.
#
#   $ echo "foobar" | cb
#   $ cb | cat
#
cb() {
    test -t 0 && pbpaste || pbcopy
}

# Clean build artifacts from the current directory.
clean() {
    find . -name ".DS_Store" -delete
    find . -name "._.DS_Store" -delete
    find . -name "._*" -delete
    find . -name ".*.swp" -delete

    if test "$1" == "python" || test "$1" == "py" || test "$1" == "all"; then
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
man() {
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
mv() {
    if [ $# -ne 1 ]; then
        command mv "$@"
        return
    fi
    read -ei "$1" new_filename
    mv -v "$1" "$new_filename"
}

# Interactive cp command for copying files.
cp() {
    if [ $# -ne 1 ]; then
        command cp "$@"
        return
    fi
    read -ei "$1" new_filename
    cp "$1" "$new_filename"
}

# Request user confirmation. First argument is used as the prompt string.
confirm() {
    local input
    while true; do
        echo -n -e "$@ (y/n) "
        read input
        case $input in
            [Yy]*)
                return 0;;
            *)
                return 1;;
        esac
    done
}

# Create a new git version tag.
tag() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "Usage: tag "
        echo "       tag <tagname>"
        echo "       tag <tagname> <commit>"
        return
    fi

    if [ $# -eq 0 ]; then
        git tag
    fi

    if [ $# -eq 1 ]; then
        git tag -am "Version $1" "$1"
    fi

    if [ $# -eq 2 ]; then
        git tag -am "Version $1" "$1" "$2"
    fi
}

# Print $PATH in readable form.
path() {
    echo $PATH | tr ':' '\n'
}

# Open notes.
nn() {
    if test ! -d "$HOME/dev/notes"; then
        echo "Error: the ~/dev/notes/ directory does not exist."
        return 1
    fi

    cd "$HOME/dev/notes"

    if test -z "$1"; then
        vim "$HOME/dev/notes/scratch.stx"
        return 0
    fi

    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        echo "Usage: nn [-l|--list] [-n|--new filename] [filename-substring]"
        return 0
    fi

    if [[ "$1" == "-l" || "$1" == "--list" ]]; then
        for file in $HOME/dev/notes/*; do
            if [[ -e "$file" ]]; then
                printf " - %s\n" $(basename "$file")
            fi
        done
        return 0
    fi

    if [[ "$1" == "-n" || "$1" == "--new" ]]; then
        if [[ -z "$2" ]]; then
            echo "Error: missing filename"
            return 1
        else
            vim "$2"
            return 0
        fi
    fi

    for file in $HOME/dev/notes/*; do
        if [[ -e "$file" ]]; then
            if [[ "$file" == *"$1"* ]]; then
                vim "$file"
                return 0
            fi
        fi
    done

    echo "Error: no file matching '$1'."
    return 1
}

# Change directory using fzf.
ff() {
    if is_executable fd; then
        local target="$(fd --type d --exclude 'Library' | fzf)"
        if test ! -z "$target"; then
            cd "$target"
        fi
    elif is_executable fdfind; then
        local target="$(fdfind --type d --exclude 'Library' | fzf)"
        if test ! -z "$target"; then
            cd "$target"
        fi
    fi
}

# Fix Karabiner Elements after sleeping.
fke() {
    sudo pkill Karabiner-DriverKit-VirtualHIDDeviceClient
    sudo pkill karabiner_console_user_server
}
