# ------------------------------------------------------------------------------
# Admin functions for the `dot` command.
# ------------------------------------------------------------------------------

function dot() {
    case "$1" in
        update)
            dot_update;;
        init)
            dot_init;;
        source|src)
            dot_source;;
        link)
            dot_link;;
        *)
            dot_help;;
    esac
}

# Print the help text for the dotfiles command.
function dot_help() {
    cat <<EOF
Usage: dot <command>

  Management utility for the dotfiles installation.

Commands:
  init      (Re)initialize the installation.
  link      Link all files in ~/.dotfiles/link into ~/.
  src       Source all files in ~/.dotfiles/source.
  update    Update the local dotfiles repository.
EOF
}

# Source all files in /source.
function dot_source() {
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
}

# Create a symlink in $HOME to each file or directory in /link.
function dot_link() {
    for targetfile in ~/.dotfiles/link/*; do
        linkfile=~/.$(basename $targetfile)
        if test -e $linkfile; then
            test -L $linkfile || mv $linkfile $linkfile.dotbackup
        fi
        ln -svf $targetfile $linkfile
    done
}

# Initialize/reinitialize the dotfiles installation.
function dot_init() {
    source ~/.dotfiles/dotfuncs.sh
    dot_source
    dot_link
}

# Update the dotfiles repository.
function dot_update() {
    local old_dir="$(pwd)"
    cd ~/.dotfiles
    local head="$(git rev-parse HEAD)"
    echo "Checking for updates..."
    if ! git pull; then
        echo "Error: can't update automatically."
        cd "$old_dir"
        return
    fi
    if [[ "$(git rev-parse HEAD)" != "$head" ]]; then
        echo "Updated. Reinitializing now..."
        dot_init
    fi
    cd "$old_dir"
}

# Request user confirmation. First argument is used as the prompt string.
function dot_confirm() {
    local input
    while true; do
        echo -n -e " \e[1;35m?\e[0m  $@ (y/n) "
        read input
        case $input in
            [Yy]*)
                dot_log "[YES]"
                return 0;;
            *)
                dot_log "[NO]"
                return 1;;
        esac
    done
}
