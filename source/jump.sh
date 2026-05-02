# ------------------------------------------------------------------------------
# Jump functions.
# ------------------------------------------------------------------------------

print_jj_help() {
    cat <<EOF
Usage: jj [target]

  - Jumps to a fuzzily-selected target directory from location history.
  - If no target is specified, interactively searches the history.
  - If the target is '.', interactively searches the current directory.

Flags:
  -h, --help        Print this help text and exit.

Also:
  jd        Interactively jumps to a directory under the current directory.
  jf        Interactively finds a file under the current directory.
  ji        Interactively jumps to a directory from location history.
EOF
}

# Jumps to a directory.
jj() {
    case "$1" in
        -h|--help)
            print_jj_help;;
        bin)
            cd ~/dev/bin;;
        dev)
            cd ~/dev;;
        dm)
            cd ~/dev/web/dmulholl.com;;
        notes)
            cd ~/dev/notes;;
        src)
            cd ~/dev/code;;
        code)
            cd ~/dev/code;;
        tmp)
            cd ~/dev/tmp;;
        vay)
            cd ~/dev/vay;;
        vim)
            cd ~/.vim;;
        "")
            ji;;
        ".")
            jd;;
        *)
            z "$@";;
    esac
}

# Interactively jumps to a directory from location history.
ji() {
    if test "$1" = "-h" || test "$1" = "--help"; then
        echo "Usage: ji"
        echo ""
        echo "  - Interactively jumps to a directory from location history."
        return 0
    fi

    local target="$(z | awk '{print $2}' | fzf --height 50%)"

    if test ! -z "$target"; then
        cd "$target"
    fi
}

# Interactively jumps to a directory under the current working directory.
jd() {
    if test "$1" = "-h" || test "$1" = "--help"; then
        echo "Usage: jd"
        echo ""
        echo "  - Interactively jumps to a directory under the current working directory."
        return 0
    fi

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

# Interactively jumps to a file under the current working directory.
# This just prints the file path.
jf() {
    if test "$1" = "-h" || test "$1" = "--help"; then
        echo "Usage: jf"
        echo ""
        echo "  - Interactively jumps to a file under the current working directory."
        echo "    (This just prints the file path.)"
        return 0
    fi

    fzf --height 50%
}
