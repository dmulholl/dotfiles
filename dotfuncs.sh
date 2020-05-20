# ------------------------------------------------------------------------------
# Admin functions for the `dot` command.
# ------------------------------------------------------------------------------

function dot() {
    local dot_backupdir="~/.dotfiles/backups/$(date "+%Y-%m-%d--%H-%M-%S")/"
    if test -n "$1"; then
        local command="$1"
        shift
        case $command in
            update)
                dot_update "$@";;
            init)
                dot_init "$@";;
            source|src)
                dot_source "$@";;
            link)
                dot_link "$@";;
            log)
                cat ~/.dotfiles/log.txt;;
            *)
                dot_help;;
        esac
    else
        dot_help
    fi
}

# Print the help text for the dotfiles command.
function dot_help() {
    cat <<EOF
Usage: dot <command>

  Management utility for the dotfiles installation.

Commands:
  init      (Re)initialize the installation.
  link      Link all files in ~/.dotfiles/link into ~/.
  log       Show the log file.
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
# Backup any existing files before overwriting.
function dot_link() {
    for srcfile in ~/.dotfiles/link/*; do
        dstfile="~/.$(basename $srcfile)"
        if test -e $dstfile; then
            test -L $dstfile || dot_backup $dstfile
            rm -rf $dstfile
        fi
        ln -sf $srcfile $dstfile
    done
}

# Initialize/reinitialize the dotfiles installation.
function dot_init() {
    source ~/.dotfiles/admin.sh
    dot_source
    dot_link
}

# Update the dotfiles repository.
function dot_update() {
    local old_dir="$(pwd)"
    cd ~/.dotfiles
    local head="$(git rev-parse HEAD)"
    echo "Checking for updates."
    if ! git pull; then
        echo "Error: cannot pull from the remote repository."
        cd "$old_dir"
        return
    fi
    if [[ "$(git rev-parse HEAD)" != "$head" ]]; then
        echo "The repository has been updated. Reinitializing now."
        dot_init
    fi
    cd "$old_dir"
}

# This function logs its arguments to file.
function dot_log() {
    echo "$(date "+%Y-%m-%d %H:%M:%S" ) :: $@" >> ~/.dotfiles/log.txt
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

# Backup a file or directory before overwriting it.
function dot_backup() {
    local target=$1
    [[ -d "$dot_backupdir" ]] || mkdir -p "$dot_backupdir"
    mv "$target" "$dot_backupdir"
}
