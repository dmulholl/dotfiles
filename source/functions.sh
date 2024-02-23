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
        if [[ -x "$(which "$1")" ]]; then
            return 0
        fi
    fi
    return 1
}

# Make a directory and cd into it in one step.
mkcd() {
    if test -n "$1"; then
        mkdir -p "$1"
        cd "$1"
    fi
}

# Uni-command for the clipboard on OSX.
#
#   $ echo "foobar" | cb
#   $ cb | cat
#
clip() {
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

# Create a new git tag.
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

# Jump to a fuzzily-selected directory.
jj() {
    case "$1" in
        bin)
            cd ~/dev/bin;;
        dev)
            cd ~/dev;;
        dm)
            cd ~/dev/web/dmulholl.com;;
        notes)
            cd ~/dev/notes;;
        src)
            cd ~/dev/src;;
        tmp)
            cd ~/dev/tmp;;
        vay)
            cd ~/dev/vay;;
        vim)
            cd ~/.vim;;
        "")
            jh;;
        *)
            z "$@";;
    esac
}

# Jump to a fuzzily-selected directory from directory-history.
jh() {
    local target="$(z | tr -s ' ' | cut -d ' ' -f 2 | fzf --height 50%)"
    if test ! -z "$target"; then
        cd "$target"
    fi
}

# Jump to a fuzzily-selected directory under the current working directory.
jd() {
    if is_executable fd; then
        local target="$(fd --type d --exclude 'Library' | fzf --height 50%)"
        if test ! -z "$target"; then
            cd "$target"
        fi
        return
    fi

    if is_executable fdfind; then
        local target="$(fdfind --type d --exclude 'Library' | fzf --height 50%)"
        if test ! -z "$target"; then
            cd "$target"
        fi
        return
    fi

    local target="$(find * -type d | fzf --height 50%)"
    if test ! -z "$target"; then
        cd "$target"
    fi
}

# Jump to a fuzzily-selected file under the current working directory.
# This just prints the filename.
jf() {
    fzf --height 50%
}

# Jump to a fuzzily-selected file under the current working directory.
# This opens the file in Vim.
jv() {
    local name="$(fzf --height 50%)"

    if test ! -z "$name"; then
        vim "$name"
    fi
}

# Jump to a fuzzily-selected note.
# This opens the note in Vim.
jn() {
    if test ! -d "$HOME/dev/notes"; then
        mkdir -p "$HOME/dev/notes"
    fi

    local lastdir="$(pwd)"
    cd "$HOME/dev/notes"
    local name="$(fzf --height 50%)"

    if test ! -z "$name"; then
        vim "$name"
    else
        cd "$lastdir"
    fi
}

# Deletes local git branches.
prune-git-branches() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        echo "Usage:"
        echo "  prune-git-branches"
        echo "  prune-git-branches -h/--help"
        echo "  prune-git-branches -p/--prune"
        echo
        echo "Run without arguments to see a list of the branches that will be deleted."
        return
    fi

    if [ "$1" = "-p" ] || [ "$1" = "--prune" ]; then
        git branch | grep --invert-match 'develop\|staging\|master\|main\|[*]' | xargs git branch -D
        return
    fi

    echo "Running with -p/--prune will delete the following branches:"
    git branch | grep --invert-match 'develop\|staging\|master\|main\|[*]'
}
