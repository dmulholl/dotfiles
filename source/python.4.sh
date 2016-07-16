# --------------------------------------------------------------------------
# Python settings.
# --------------------------------------------------------------------------

# Custom library directories.
export PYTHONPATH=~/dev/lib:~/.dotfiles/lib/python

# Disable the default virtualenv prompt.
export VIRTUAL_ENV_DISABLE_PROMPT=true

# Require a virtual environment to be active for pip to function.
# We don't want to accidentally mess with the system-wide Python installation.
export PIP_REQUIRE_VIRTUALENV=true

# Explicit system-wide Python 2 pip.
function syspip2() {
    PIP_REQUIRE_VIRTUALENV="" pip2 "$@"
}

# Explicit system-wide Python 3 pip.
function syspip3() {
    PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

# --------------------------------------------------------------------------
# Virtual environment utilities.
# --------------------------------------------------------------------------

# Store all virtual environments in the following directory.
export VENVHOME=~/.virtualenvs

# Activate a virtual environment. Print an error message on failure.
function pv-activate() {
    if [[ -n "$1" ]]; then
        local name="$1"
        local script=$VENVHOME/$name/bin/activate
        if [[ -e $script ]]; then
            source $script
        else
            echo "Error: no virtual environment named '$name'."
        fi
    else
        echo "Error: you must specify the name of a virtual environment."
    fi
}

# Silently try to activate a virtual environment. No error on failure.
function pv-try-activate() {
    local script=$VENVHOME/$1/bin/activate
    if [[ -e $script ]]; then
        source $script
    fi
}

# Create a new virtual environment.
function pv-make() {
    if [[ -n "$1" ]]; then
        local name="$1"
        local path=$VENVHOME/$name
        shift
        if [[ ! -d $VENVHOME ]]; then
            mkdir -p $VENVHOME
        fi
        if [[ -d $path ]]; then
            echo "Error: '$name' already exists."
        else
            virtualenv --always-copy $path $@ && pv-activate $name
        fi
    else
        echo "Error: you must specify a name for the new virtual environment."
    fi
}

# Delete a list of virtual environments.
function pv-remove() {
    if [[ $# -ne 0 ]]; then
        for name in "$@"; do
            local path=$VENVHOME/$name
            if [[ -d $path ]]; then
                rm -rf $path
            else
                echo "Error: no virtual environment named '$name'."
            fi
        done
    else
        echo "Error: you must specify the name of a virtual environment."
    fi
}

# List all virtual environments.
function pv-list() {
    /bin/ls -m $VENVHOME
}

# Print help.
function pv-help() {
    cat <<EOF
Usage: pv <command> <args>

  Utility for managing Python virtual environments.

Commands:

  a, activate <name>       activate the named virtual environment
  d, deactivate            deactivate the current virtual environment
  h, help                  print this help message and exit
  l, ls, list              list all virtual environments
  m, mk, make <name>       make a new virtual environment
  r, rm, remove <names>    delete one or more virtual environments

Environments:

EOF
    echo -n "  " && /bin/ls -m $VENVHOME
}

# Public interface for the suite of utility functions.
function pv() {
    if [[ -n "$1" ]]; then
        local command="$1"
        shift
        case "$command" in
            a|activate)
                pv-activate "$@";;
            d|deactivate)
                deactivate;;
            h|help|--help)
                pv-help;;
            l|ls|list)
                pv-list "$@";;
            m|mk|make)
                pv-make "$@";;
            r|rm|remove)
                pv-remove "$@";;
            *)
                pv-activate "$command" "$@";;
        esac
    else
        pv-help
    fi
}
