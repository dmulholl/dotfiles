
# -------------------------------------------------------------------------
# Functions used internally by the dotfiles installation
# -------------------------------------------------------------------------

# Log to file.
function df_log() {
    echo "$(date "+%Y-%m-%d %H:%M:%S" ) >> $@" >> $df_logfile
}

# Create a visible header in the log file.
function df_log_header() {
    df_log "--------------------------------------------------"
    df_log "$@"
    df_log "--------------------------------------------------"
}

# Logging functions.
function df_title() { df_log "## $@" && echo -e "\n\033[1m$@\033[0m"; }
function df_check() { df_log "$@" && echo -e " \033[0;32m✔\033[0m  $@"; }
function df_error() { df_log "$@" && echo -e " \033[0;31m✖\033[0m  $@"; }
function df_arrow() { df_log "$@" && echo -e " \033[0;34m➜\033[0m  $@"; }

# Request user confirmation.
function df_yesno() {
    local input
    df_log "$@"
    while true; do
        echo -n -e " \033[1;35m?\033[0m  $@ (y/n) "
        read input
        case $input in
            [Yy]*) return 0;;
            [Nn]*) return 1;;
            *) df_error " .. please answer yes or no";;
        esac
    done
}

# Print the help text for the dotfiles command.
function df_help() {
    cat <<TEXT
Usage: dot <command>

  Management utility for the dotfiles installation.

Commands:
  update    update the local repository
  init      reinitialize the installation
  source    source all files in /source
  link      link all files in /link into ~/
  log       print the log file
TEXT
}

# Backup a file or directory before overwriting it.
function df_backup() {
    local target=$1
    [[ $verbose ]] && df_arrow " .. backing up $(basename $target)"
    [[ -d "$df_backups" ]] || mkdir -p "$df_backups"
    mv "$target" "$df_backups"
}

# Source all files in the repository's /source directory.
function df_source() {
    local file verbose
    [[ "$1" == "-v" || "$1" == "--verbose" ]] && verbose="on"
    [[ $verbose ]] && df_title "Sourcing files..."
    for i in $(seq 0 9); do
        for file in $DOTFILES/source/*.$i.sh; do
            if [[ ! $file =~ "*" ]]; then
                [[ $verbose ]] && df_arrow "Sourcing: $(basename $file)"
                source $file
            fi
        done
    done
}

# Create symbolic links to all files in the repository's /link directory.
function df_link() {
    local verbose srcfile trgfile
    [[ "$1" == "-v" || "$1" == "--verbose" ]] && verbose="on"
    [[ $verbose ]] && df_title "Linking files into ~/"
    for srcfile in $DOTFILES/link/*; do
        trgfile=~/.$(basename $srcfile)
        [[ $verbose ]] && df_arrow "Linking: ~/$(basename $trgfile)"
        if [[ -e $trgfile ]]; then
            [[ -h $trgfile ]] || df_backup $trgfile
            rm -rf $trgfile
        fi
        ln -sf $srcfile $trgfile
    done
}

# Run the OS-specific initialization scripts.
function df_init_os() {
    df_title "Setting OS defaults"
    is_osx && df_arrow "OSX detected" && source $DOTFILES/os/osx.sh
    is_linux && df_arrow "Linux detected"
    is_bsd && df_arrow "BSD detected"
    is_msys && df_arrow "MSys detected"
    is_cygwin && df_arrow "Cygwin detected"
}

# (Re)initialize the dotfiles installation.
function df_init() {
    df_log_header "Initializing Installation"
    find $DOTFILES -name ".DS_Store" -delete
    source $DOTFILES/dotfuncs.sh
    df_source --verbose
    df_link --verbose
    df_init_os
}

# Update the dotfiles repository.
function df_update() {
    local old_dir="$(pwd)"
    cd $DOTFILES
    local head="$(git rev-parse HEAD)"
    df_log_header "Updating Installation"
    df_title "Checking for updates..."
    if ! git pull >> $df_logfile 2>&1; then
        df_error "Cannot pull from the remote repository"
        cd "$old_dir"
        return
    fi
    if [[ "$(git rev-parse HEAD)" == "$head" ]]; then
        df_check "The repository is already up to date"
    else
        df_arrow "The repository has been updated"
        df_yesno "Reinitialize the installation?" && df_init
    fi
    cd "$old_dir"
}

# Public interface for the suite of utility functions.
function dot() {
    local df_backups="$DOTFILES/backups/$(date "+%Y-%m-%d--%H-%M-%S")/"
    local df_logfile="$DOTFILES/log.txt"
    if [[ -n "$1" ]]; then
        local command="$1"
        shift
        case $command in
            update)
                df_update "$@";;
            init)
                df_init "$@";;
            source|src)
                df_source "$@";;
            link)
                df_link "$@";;
            log)
                cat $df_logfile;;
            *)
                df_help;;
        esac
    else
        df_help
    fi
}
