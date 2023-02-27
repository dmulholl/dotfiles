# ------------------------------------------------------------------------------
# Admin functions for the `dot` command.
# ------------------------------------------------------------------------------

dot() {
    local cmd="$1"
    shift
    case "$cmd" in
        env)
            dot_env "$@";;
        init)
            dot_init "$@";;
        link)
            dot_link "$@";;
        source)
            dot_source "$@";;
        prompt)
            dot_prompt "$@";;
        fix)
            dot_fix "$@";;
        ""|-h|--help)
            dot_help;;
        *)
            echo "Error: invalid command."
            return 1
            ;;
    esac
}

dot_help() {
    cat <<EOF
Usage: dot <command>

  Dotfiles management utility.

  To update the installation:

    $ cd ~/.dotfiles
    $ git pull
    $ dot init

Flags:
  -h, --help    Print this help text and exit.

Commands:
  env           Loads environment variables from ~/.env/.
  init          (Re)initializes the dotfiles installation.
  link          Links all files in ~/.dotfiles/link/ into ~/.
  prompt        Sets the shell prompt.
  source        Sources all files in ~/.dotfiles/source/.
EOF
}

# Source all files in ~/.dotfiles/source/.
dot_source() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        dot_source_help
        return 0
    fi

    source ~/.dotfiles/source/colours.sh
    source ~/.dotfiles/source/functions.sh
    source ~/.dotfiles/source/options.sh
    source ~/.dotfiles/source/path.sh
    source ~/.dotfiles/source/aliases.sh
    source ~/.dotfiles/source/env.sh
    source ~/.dotfiles/source/go.sh
    source ~/.dotfiles/source/history.sh
    source ~/.dotfiles/source/python.sh
    source ~/.dotfiles/source/swift.sh
    source ~/.dotfiles/source/z.sh
    source ~/.dotfiles/source/prompt.sh
    source ~/.dotfiles/source/jump.sh
    source ~/.dotfiles/source/git-completion.bash
}

dot_source_help() {
    cat <<EOF
Usage: dot source

  Sources all files in the ~/.dotfiles/source/ directory.

Flags:
  -h, --help    Print this help text and exit.
EOF
}

# Create a symlink in $HOME to each file or directory in ~/.dotfiles/link/.
dot_link() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        dot_link_help
        return 0
    fi

    # Names that don't begin with '.'.
    for target in ~/.dotfiles/link/*; do
        local link="$HOME/$(basename $target)"
        if test -e "$link"; then
            if test -L "$link"; then
                rm "$link"
            else
                echo "WARN: a file '$link' already exists, moving to '$link.dotbackup'"
                mv "$link" "$link.dotbackup"
            fi
        fi
        ln -svf $target $link
    done

    # Names that begin with '.' (but not '.' or '..').
    for target in ~/.dotfiles/link/.[^.]*; do
        local link="$HOME/$(basename $target)"
        if test -e "$link"; then
            if test -L "$link"; then
                rm "$link"
            else
                echo "WARN: a file '$link' already exists, moving to '$link.dotbackup'"
                mv "$link" "$link.dotbackup"
            fi
        fi
        ln -svf $target $link
    done
}

dot_link_help() {
    cat <<EOF
Usage: dot link

  Creates a symlink in \$HOME to each file or directory in the
  ~/.dotfiles/link/ directory.

Flags:
  -h, --help    Print this help text and exit.
EOF
}

# Initialize/reinitialize the dotfiles installation.
dot_init() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        dot_init_help
        return 0
    fi

    source ~/.dotfiles/dot_cmd.sh
    dot_source
    dot_link
    dotpy_try_activate base
}

dot_init_help() {
    cat <<EOF
Usage: dot init

  Initializes or re-initializes the dotfiles installation.

Flags:
  -h, --help    Print this help text and exit.
EOF
}

# Load environment variables from ~/.env/.
dot_env() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        dot_env_help
        return 0
    fi

    if test ! -d "$HOME/.env"; then
        echo "Error: the ~/.env/ directory does not exist."
        return 1
    fi

    if [[ "$1" == "-v" || "$1" == "--view" ]]; then
        local leading_newline=""
        for file in $HOME/.env/*.sh; do
            if [[ -e "$file" ]]; then
                printf "$leading_newline\e[32m· %s\e[39m\n\n" $(basename $file)
                leading_newline="\n"
                cat "$file"
            fi
        done
        return 0
    fi

    if [[ "$1" == "-l" || "$1" == "--list" || "$1" == "" ]]; then
        pushd "$HOME/.env" > /dev/null
        for file in *.sh; do
            if test -e "$file"; then
                local name="${file%.auto.sh}"
                name="${name%.sh}"
                local env_var_name="DOT_ENV_LOADED_$name"
                if test -z "${!env_var_name}"; then
                    printf " - %s\n" "$name"
                else
                    printf " * %s\n" "$name"
                fi
            fi
        done
        popd > /dev/null
        return 0
    fi

    if test -e "$HOME/.env/$1.sh"; then
        source "$HOME/.env/$1.sh"
        export "DOT_ENV_LOADED_$1"="true"
    elif test -e "$HOME/.env/$1.auto.sh"; then
        source "$HOME/.env/$1.auto.sh"
        export "DOT_ENV_LOADED_$1"="true"
    else
        echo "Error: no file in ~/.env/ for '$1'."
        return 1
    fi
}

dot_env_help() {
    cat <<EOF
Usage: dot env

  Loads environment variables from the ~/.env/ directory.

Flags:
  -h, --help    Print this help text and exit.
  -l, --list    List available files.
  -v, --view    Show file content.
EOF
}

dot_fix() {
    local target="$1"
    shift
    case "$target" in
        ke)
            # Fix Karabiner Elements after sleeping.
            sudo pkill Karabiner-DriverKit-VirtualHIDDeviceClient
            sudo pkill karabiner_console_user_server
            ;;
        ""|-h|--help)
            echo "Usage: dot fix <target>"
            return 0
            ;;
        *)
            echo "Error: invalid target for 'fix'."
            return 1
            ;;
    esac
}
