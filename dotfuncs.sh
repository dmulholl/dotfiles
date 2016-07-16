# --------------------------------------------------------------------------
# Functions used internally by the dotfiles installation.
# --------------------------------------------------------------------------

# Public 'dot' interface for the suite of dotfiles utility functions.
function dot() {
    local dot_backups="$DOTFILES/backups/$(date "+%Y-%m-%d--%H-%M-%S")/"
    if [[ -n "$1" ]]; then
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
                cat $DOTFILES/log.txt;;
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
  update    Update the local repository.
  init      (Re)initialize the installation.
  src       Source all files in /source.
  link      Link all files in /link into ~/.
  log       Print the log file to stdout.
EOF
}

# Log to file.
function dot_log() {
    echo "$(date "+%Y-%m-%d %H:%M:%S" ) >> $@" >> $DOTFILES/log.txt
}

# Create a visible header in the log file.
function dot_log_header() {
    dot_log "-------------------------------------------------------"
    dot_log "$@"
    dot_log "-------------------------------------------------------"
}

# Logging functions. Print to both the log file and stdout.
function dot_title() { dot_log "## $@" && echo -e "\n\033[1m$@\033[0m"; }
function dot_check() { dot_log "$@" && echo -e " \033[0;32m✔\033[0m  $@"; }
function dot_error() { dot_log "$@" && echo -e " \033[0;31m✖\033[0m  $@"; }
function dot_arrow() { dot_log "$@" && echo -e " \033[0;34m➜\033[0m  $@"; }

# Request user confirmation.
function dot_confirm() {
    local input
    dot_log "$@"
    while true; do
        echo -n -e " \033[1;35m?\033[0m  $@ (y/n) "
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
    [[ $verbose ]] && dot_arrow " .. backing up $(basename $target)"
    [[ -d "$dot_backups" ]] || mkdir -p "$dot_backups"
    mv "$target" "$dot_backups"
}

# Source all files in the repository's /source directory.
function dot_source() {
    local file verbose
    [[ "$1" == "-v" || "$1" == "--verbose" ]] && verbose="on"
    [[ $verbose ]] && dot_title "Sourcing files:"
    for i in $(seq 0 9); do
        for file in $DOTFILES/source/*.$i.sh; do
            if [[ ! $file =~ "*" ]]; then
                [[ $verbose ]] && dot_arrow "Sourcing: $(basename $file)"
                source $file
            fi
        done
    done
}

# Create symbolic links to all files in the repository's /link directory.
function dot_link() {
    local verbose srcfile trgfile
    [[ "$1" == "-v" || "$1" == "--verbose" ]] && verbose="on"
    [[ $verbose ]] && dot_title "Linking files into ~/"
    for srcfile in $DOTFILES/link/*; do
        dstfile=~/.$(basename $srcfile)
        [[ $verbose ]] && dot_arrow "Linking: ~/$(basename $dstfile)"
        if [[ -e $dstfile ]]; then
            [[ -h $dstfile ]] || dot_backup $dstfile
            rm -rf $dstfile
        fi
        ln -sf $srcfile $dstfile
    done
}

# (Re)initialize the dotfiles installation.
function dot_init() {
    cat <<EOF
------------------------------------
 Initializing Dotfiles Installation
------------------------------------
EOF
    dot_log_header "Initializing Installation"
    find $DOTFILES -name ".DS_Store" -delete
    source $DOTFILES/dotfuncs.sh
    dot_source --verbose
    dot_link --verbose
    dot_init_os
}

# Run the OS-specific initialization scripts.
function dot_init_os() {
    dot_title "Setting OS defaults"
    is_mac && dot_arrow "OSX detected"
    is_linux && dot_arrow "Linux detected"
    is_bsd && dot_arrow "BSD detected"
    is_msys && dot_arrow "MSys detected"
    is_cygwin && dot_arrow "Cygwin detected"
}

# Update the dotfiles repository.
function dot_update() {
    local old_dir="$(pwd)"
    cd $DOTFILES
    local head="$(git rev-parse HEAD)"
    dot_log_header "Updating Installation"
    dot_title "Checking for updates..."
    if ! git pull >> $DOTFILES/log.txt 2>&1; then
        dot_error " .. cannot pull from the remote repository"
        cd "$old_dir"
        return
    fi
    if [[ "$(git rev-parse HEAD)" == "$head" ]]; then
        dot_check " .. the repository is already up to date"
    else
        dot_arrow " .. the repository has been updated"
        dot_confirm "Reinitialize the installation?" && dot_init
    fi
    cd "$old_dir"
}
