
# ----------------------------------------------------------------------------
# Functions used internally by the dotfiles installation
# ----------------------------------------------------------------------------

# Logging functions.
function e_title() { echo -e "\n\033[1m$@\033[0m"; }
function e_check() { echo -e " \033[0;32m✔\033[0m  $@"; }
function e_error() { echo -e " \033[0;31m✖\033[0m  $@"; }
function e_arrow() { echo -e " \033[0;34m➜\033[0m  $@"; }

# Are we (re)initializing the installation?
function is_init() {
    [[ $dotinit ]]
}

# Source all files in the repository's /source directory.
function src() {
    local file verbose
    [[ "$1" == "-v" || "$1" == "--verbose" ]] && verbose="on"
    [[ $verbose ]] && e_title "Sourcing files..."
    for i in $(seq 0 9); do
        for file in $DOTFILES/source/*.$i.sh; do
            if [[ ! $file =~ "*" ]]; then
                [[ $verbose ]] && e_arrow "Sourcing: $(basename $file)"
                source $file
            fi
        done
    done
}

# Print the help text for the dotfiles command.
function dotfiles_help() {
    cat <<TEXT
Usage: dotfiles

  Reinitialization command for the dotfiles installation.
  See the readme for details:

  https://github.com/dmulholland/dotfiles
TEXT
}

# Update the dotfiles repository.
function dotfiles_update() {
    e_title "Checking for updates..."
    cd $DOTFILES
    local prev_head="$(git rev-parse HEAD)"
    git pull &> /dev/null || e_error "Cannot pull from remote repository"
    if [[ "$(git rev-parse HEAD)" != "$prev_head" ]]; then
        e_check "Dotfiles repository updated"
    else
        e_arrow "No updates found"
    fi
}

# Reinitialize the dotfiles installation.
function dotfiles() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        dotfiles_help
    else
        dotfiles_update
        source $DOTFILES/init.sh
    fi
}
