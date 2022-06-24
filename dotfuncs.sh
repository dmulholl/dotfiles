# ------------------------------------------------------------------------------
# Admin functions for the `dot` command.
# ------------------------------------------------------------------------------

dot() {
    case "$1" in
        env)
            dot_env "$2";;
        init)
            dot_init;;
        link)
            dot_link;;
        source|src)
            dot_source;;
        prompt)
            dot_prompt "$2";;
        *)
            dot_help;;
    esac
}

# Print the help text for the dotfiles command.
dot_help() {
    cat <<EOF
Usage: dot <command>

  Dotfiles management utility.

  To update the installation:

    $ cd ~/.dotfiles
    $ git pull
    $ dot init

Commands:
  env [-v|--view]     Loads environment variables from ~/.env/.
  init                (Re)initializes the installation.
  link                Links all files in ~/.dotfiles/link/ into ~/.
  prompt [-h|--help]  Sets the shell prompt.
  source              Sources all files in ~/.dotfiles/source/.
EOF
}

# Source all files in ~/.dotfiles/source/.
dot_source() {
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

# Create a symlink in $HOME to each file or directory in ~/.dotfiles/link/.
dot_link() {
    for target_file in ~/.dotfiles/link/*; do
        local link_file=~/.$(basename $target_file)
        if test -e $link_file; then
            if test -L $link_file; then
                rm $link_file
            else
                echo "Error: failed to link '$target_file', a file '$link_file' already exists."
                continue
            fi
        fi
        ln -svf $target_file $link_file
    done
}

# Initialize/reinitialize the dotfiles installation.
dot_init() {
    source ~/.dotfiles/dotfuncs.sh
    dot_source
    dot_link
    dotpy_try_activate base
}

# Load environment variables from ~/.env/.
dot_env() {
    if test ! -d "$HOME/.env"; then
        echo "Error: the ~/.env/ directory does not exist."
        return 1
    fi

    if test -z "$1"; then
        for file in $HOME/.env/*.sh; do
            if [[ -e "$file" ]]; then
                if [[ "$file" = *.auto.sh ]]; then
                    printf " + %s\n" $(basename -s ".auto.sh" "$file")
                else
                    printf " - %s\n" $(basename -s ".sh" "$file")
                fi
            fi
        done
        return 0
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

    if test -e "$HOME/.env/$1.sh"; then
        source "$HOME/.env/$1.sh"
    elif test -e "$HOME/.env/$1.auto.sh"; then
        source "$HOME/.env/$1.auto.sh"
    else
        echo "Error: no file in ~/.env/ for '$1'."
    fi
}
