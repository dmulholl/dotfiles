# ------------------------------------------------------------------------------
# Jump functions.
# ------------------------------------------------------------------------------

print_jj_help() {
    cat <<EOF
Usage: jj [target]

  - Jumps to a fuzzily-selected target directory from location history.
  - If no target is specified, interactively searches location history.
  - If the target is '.', interactively searches the current directory.

Flags:
  -h, --help        Print this help text and exit.
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
        vim)
            cd ~/.vim;;
        "")
            _dot_jj_directory_from_history;;
        ".")
            _dot_jj_directory_from_current;;
        *)
            z "$@";;
    esac
}

# Interactively jumps to a directory from location history.
_dot_jj_directory_from_history() {
    local target="$(z | awk '{print $2}' | fzf --height 50%)"
    if test ! -z "$target"; then
        cd "$target"
    fi
}

# Interactively jumps to a directory under the current directory.
_dot_jj_directory_from_current() {
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

print_ff_help() {
    cat <<EOF
Usage: ff

  Interactively searches for and copies a filepath under the current directory.

Flags:
  -h, --help        Print this help text and exit.
EOF
}

# Interactively searches for and copies a filepath under the current directory.
ff() {
    if test "$1" = "-h" || test "$1" = "--help"; then
        print_ff_help
        return 0
    fi

    local target="$(fzf --height 50%)"
    if test ! -z "$target"; then
        echo "copied: $target"
        echo -n "$target" | pbcopy
    fi
}
