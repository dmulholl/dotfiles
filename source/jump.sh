# ------------------------------------------------------------------------------
# Jump functions.
# ------------------------------------------------------------------------------

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
