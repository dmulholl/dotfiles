# --------------------------------------------------------------------------
# Python
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
    PIP_REQUIRE_VIRTUALENV="" /usr/local/bin/pip "$@"
}

# Explicit system-wide Python 3 pip.
function syspip3() {
    PIP_REQUIRE_VIRTUALENV="" /usr/local/bin/pip3 "$@"
}

# --------------------------------------------------------------------------
# Virtual environment utilities
# --------------------------------------------------------------------------

# Store all virtual environments in the following directory.
export VENVHOME=~/.virtualenvs

# Activate a virtual environment.
function pv-ac() {
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

# Create a new virtual environment.
function pv-mk() {
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
            virtualenv --always-copy $path $@ && pv-ac $name
        fi
    else
        echo "Error: you must specify a name for the new virtual environment."
    fi
}

# Delete a list of virtual environments.
function pv-rm() {
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
function pv-ls() {
    ls $VENVHOME
}

# Print help.
function pv-help() {
    cat <<EOF
Usage: pv <command> <args>

  Utility for managing Python virtual environments.

Commands:

  a, activate <name>    activate the named virtual environment
  h, help               print this help message and exit
  l, list               list all virtual environments
  m, make <name>        make a new virtual environment
  d, delete <names>     delete one or more virtual environments
EOF
}

# Public interface for the suite of utility functions.
function pv() {
    if [[ -n "$1" ]]; then
        local command="$1"
        shift
        case "$command" in
            a|activate)
                pv-ac "$@";;
            l|list)
                pv-ls "$@";;
            m|make)
                pv-mk "$@";;
            d|delete)
                pv-rm "$@";;
            h|help|--help)
                pv-help;;
            *)
                pv-ac "$command" "$@";;
        esac
    else
        pv-help
    fi
}
