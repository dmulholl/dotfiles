# ------------------------------------------------------------------------------
# Dot commands.
# ------------------------------------------------------------------------------

dot_help() {
    cat <<EOF
Usage: dot <command>

  Dot commands. To view the help text for a command, run:

    dot <command> [-h/--help]

  To update the dotfiles installation, run:

    cd ~/.dotfiles
    git pull
    dot install

  To install the dotfiles on a new machine, run:

    git clone https://github.com/dmulholl/dotfiles.git ~/.dotfiles
    source ~/.dotfiles/install.sh

Flags:
  -h, --help    Print this help text and exit.

Utility Commands:
  backup        Run a backup script.
  clean         Delete build artifacts from the current directory.
  env           Load environment variables from ~/.env/.
  fix           Run a fix command.
  init          Initialize a new project directory from a template.
  keys          List keyboard shortcuts.
  path          Print PATH entries.
  prompt        Set the shell prompt.
  prune         Delete git branches.
  pyenv         Manage Python environments.

Admin Commands:
  dot           Print the dotfiles installation command.
  install       Re-run the dotfiles installation routine.
  link          Link all files in ~/.dotfiles/link/ into ~/.
  source        Source all files in ~/.dotfiles/source/. Alias '.'.
EOF
}

dot() {
    local cmd="$1"
    shift

    case "$cmd" in
        ""|-h|--help)
            dot_help;;
        dot)
            dot_dot "$@";;
        env)
            dot_env "$@";;
        fix)
            dot_fix "$@";;
        install)
            dot_install "$@";;
        link)
            dot_link "$@";;
        path)
            dot_path "$@";;
        prompt)
            dot_prompt "$@";;
        prune)
            dot_prune "$@";;
        pyenv)
            dot_pyenv "$@";;
        source|.)
            dot_source "$@";;
        init)
            ~/.dotfiles/commands/init "$@";;
        backup)
            ~/.dotfiles/commands/backup "$@";;
        keys)
            ~/.dotfiles/commands/keys "$@";;
        clean)
            ~/.dotfiles/commands/clean "$@";;
        *)
            echo "Error: invalid command."
            return 1
            ;;
    esac
}

dot_source_help() {
    cat <<EOF
Usage: dot source

  Sources all files in the ~/.dotfiles/source/ directory.

Flags:
  -h, --help    Print this help text and exit.
EOF
}

dot_source() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        dot_source_help
        return 0
    fi

    source ~/.dotfiles/source/env.sh
    source ~/.dotfiles/source/z.sh
    source ~/.dotfiles/source/colours.sh
    source ~/.dotfiles/source/functions.sh
    source ~/.dotfiles/source/options.sh
    source ~/.dotfiles/source/path.sh
    source ~/.dotfiles/source/aliases.sh
    source ~/.dotfiles/source/go.sh
    source ~/.dotfiles/source/history.sh
    source ~/.dotfiles/source/python.sh
    source ~/.dotfiles/source/swift.sh
    source ~/.dotfiles/source/prompt.sh
    source ~/.dotfiles/source/fzf.sh
    source ~/.dotfiles/source/bash-completion.sh
    source ~/.dotfiles/source/git-completion.bash

    if test -e "$HOME/.dotlocal/source.sh"; then
        source "$HOME/.dotlocal/source.sh"
    fi
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

dot_link() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        dot_link_help
        return 0
    fi

    # This makes a mess when * is empty.
    # Names that don't begin with '.'.
    # for target in ~/.dotfiles/link/*; do
    #     local link="$HOME/$(basename $target)"
    #     if test -e "$link"; then
    #         if test -L "$link"; then
    #             rm "$link"
    #         else
    #             echo "WARN: a file '$link' already exists, moving to '$link.dotbackup'"
    #             mv "$link" "$link.dotbackup"
    #         fi
    #     fi
    #     ln -svf $target $link
    # done

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

dot_install_help() {
    cat <<EOF
Usage: dot install

  Initializes/re-initializes the dotfiles installation.

Flags:
  -c, --command     Print the installation command.
  -h, --help        Print this help text and exit.
EOF
}

dot_install() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        dot_install_help
        return 0
    fi

    if [[ "$1" == "-c" || "$1" == "--command" ]]; then
        echo "git clone https://github.com/dmulholl/dotfiles.git ~/.dotfiles && source ~/.dotfiles/install.sh"
        return 0
    fi

    source ~/.dotfiles/dot.sh
    dot_source
    dot_link
    dotpy_try_activate base
}

dot_env_help() {
    cat <<EOF
Usage: dot env

  Loads environment variables from the ~/.dotlocal/env/ directory.

Flags:
  -h, --help    Print this help text and exit.
  -l, --list    List available files.
  -v, --view    Show file content.
EOF
}

dot_env() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        dot_env_help
        return 0
    fi

    if test ! -d "$HOME/.dotlocal/env"; then
        echo "Error: the ~/.dotlocal/env/ directory does not exist."
        return 1
    fi

    if [[ "$1" == "-v" || "$1" == "--view" ]]; then
        local leading_newline=""
        for file in $HOME/.dotlocal/env/*.sh; do
            if [[ -e "$file" ]]; then
                printf "$leading_newline\e[32m· %s\e[39m\n\n" $(basename $file)
                leading_newline="\n"
                cat "$file"
            fi
        done
        return 0
    fi

    if [[ "$1" == "-l" || "$1" == "--list" || "$1" == "" ]]; then
        pushd "$HOME/.dotlocal/env" > /dev/null
        for file in *.sh; do
            if test -e "$file"; then
                local name="${file%.auto.sh}"
                name="${name%.sh}"
                local env_var_name="DOT_ENV_LOADED_${name//-/_}"
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

    if test -e "$HOME/.dotlocal/env/$1.sh"; then
        source "$HOME/.dotlocal/env/$1.sh"
        export "DOT_ENV_LOADED_${1//-/_}"="true"
    elif test -e "$HOME/.dotlocal/env/$1.auto.sh"; then
        source "$HOME/.dotlocal/env/$1.auto.sh"
        export "DOT_ENV_LOADED_${1//-/_}"="true"
    else
        echo "Error: no file in ~/.dotlocal/env/ for '$1'."
        return 1
    fi
}

dot_fix_help() {
    cat <<EOF
Usage: dot fix <target>

  Runs a fix command.

Targets:
  ke            Fix Karabiner Elements after sleeping.

Flags:
  -h, --help    Print this help text and exit.
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
            dot_fix_help
            return 0
            ;;
        *)
            echo "Error: invalid target for 'fix'."
            return 1
            ;;
    esac
}

dot_path_help() {
    cat <<EOF
Usage: dot path

  Prints the PATH environment variable, one entry per line.

Flags:
  -h, --help    Print this help text and exit.
EOF
}

dot_path() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        dot_path_help
        return 0
    fi

    echo $PATH | tr ':' '\n'
}

dot_prune_help() {
    cat <<EOF
Usage: dot prune

  Deletes local git branches.

  - Never deletes the current branch.
  - Run without arguments to see a list of the branches that will be deleted.

Flags:
  -h, --help    Print this help text and exit.
  -p, --prune   Delete branches.
EOF
}

dot_prune() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        dot_prune_help
        return 0
    fi

    if [ "$1" = "-p" ] || [ "$1" = "--prune" ]; then
        git branch | grep --invert-match 'develop\|staging\|master\|main\|[*]' | xargs git branch -D
        return 0
    fi

    echo "Running with -p/--prune will delete the following branches:"
    git branch | grep --invert-match 'develop\|staging\|master\|main\|[*]'
}

dot_dotfiles_help() {
    cat <<EOF
Usage: dot dotfiles

  Prints the dotfiles installation command.

Flags:
  -h, --help    Print this help text and exit.
EOF
}

dot_dot() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        dot_dotfiles_help
        return 0
    fi

    echo "git clone https://github.com/dmulholl/dotfiles.git ~/.dotfiles && source ~/.dotfiles/install.sh"
}
