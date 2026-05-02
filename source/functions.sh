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

# Tests if the argument is an executable script, binary, or symlink on PATH,
# or a shell alias or function.
is_command() {
    if type $1 &> /dev/null; then
        return 0
    fi
    return 1
}

# Tests if the argument is an executable script, binary, or symlink on PATH.
is_executable() {
    if which "$1" &> /dev/null; then
        if test -x "$(which "$1")"; then
            return 0
        fi
    fi
    return 1
}

# Creates one or more empty files.
mkf() {
    if test -z "$1" || test "$1" = "-h" || test "$1" = "--help"; then
        printf "Usage: mkf <path> [<path>...]\n\n  Creates an empty file at <path>. Creates parent directories if required.\n"
        return 0
    fi

    for file in "$@"; do
        local dirpath=$(dirname "$file")

        if ! test -d "$dirpath"; then
            mkdir -p "$dirpath"
        fi

        touch "$file"
    done
}

# Creates one or more directories.
mkd() {
    if test -z "$1" || test "$1" = "-h" || test "$1" = "--help"; then
        printf "Usage: mkd <path> [<path>...]\n\n  Creates a directory at <path>. Creates parent directories if required.\n"
        return 0
    fi

    for path in "$@"; do
        mkdir -p "$path"
    done
}

# Creates a directory and sets it as the current directory.
mkcd() {
    if test -z "$1" || test "$1" = "-h" || test "$1" = "--help"; then
        printf "Usage: mkcd <path>\n\n  Creates a directory at <path> and sets it as the current directory.\n  Creates parent directories if required.\n"
        return 0
    fi

    mkdir -p "$1"
    cd "$1"
}

# Uni-command for the clipboard on OSX.
#
#   $ echo "foobar" | clip
#   $ clip | cat
#
clip() {
    test -t 0 && pbpaste || pbcopy
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

# Create a new git tag.
tag() {
    if test "$1" = "-h" || test "$1" = "--help"; then
        echo "Usage: tag "
        echo "       tag <tagname>"
        echo "       tag <tagname> <commit>"
        return
    fi

    if test $# -eq 0; then
        git tag
    fi

    if test $# -eq 1; then
        git tag -am "Version $1" "$1"
    fi

    if test $# -eq 2; then
        git tag -am "Version $1" "$1" "$2"
    fi
}
