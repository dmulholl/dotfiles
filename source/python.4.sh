# ------------------------------------------------------------------------------
# Python settings.
# ------------------------------------------------------------------------------

# Custom library directories.
export PYTHONPATH=~/dev/lib/python:~/.dotfiles/lib/python

# Disable the default virtualenv prompt.
export VIRTUAL_ENV_DISABLE_PROMPT=true

# Require a virtual environment to be active for pip to function. We don't
# want to accidentally mess with the system or homebrew Python installations.
export PIP_REQUIRE_VIRTUALENV=true

# Install a package using the global version of Python 2.
function syspip2() {
    PIP_REQUIRE_VIRTUALENV="" pip2 "$@"
}

# Install a package using the global version of Python 3.
function syspip3() {
    PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

# --------------------------------------------------------------------------
# Virtual environment utilities.
# --------------------------------------------------------------------------

# Store all virtual environments in the following directory.
export DOTPYENVS=~/.dotpyenvs

# Activate a virtual environment. Print an error message on failure.
function dotpy-activate() {
    if [[ -n "$1" ]]; then
        local name="$1"
        local script=$DOTPYENVS/$name/bin/activate
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
function dotpy-try-activate() {
    local script=$DOTPYENVS/$1/bin/activate
    if [[ -e $script ]]; then
        source $script
    fi
}

# Create a new virtual environment.
function dotpy-make() {
    if [[ -n "$1" ]]; then
        local name="$1"
        local path=$DOTPYENVS/$name
        shift
        if [[ ! -d $DOTPYENVS ]]; then
            mkdir -p $DOTPYENVS
        fi
        if [[ -d $path ]]; then
            echo "Error: '$name' already exists."
        else
            virtualenv --always-copy $path $@ && dotpy-activate $name
        fi
    else
        echo "Error: you must specify a name for the new virtual environment."
    fi
}

# Delete a list of virtual environments.
function dotpy-remove() {
    if [[ $# -ne 0 ]]; then
        for name in "$@"; do
            local path=$DOTPYENVS/$name
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
function dotpy-list() {
    /bin/ls -m $DOTPYENVS
}

# Print help.
function dotpy-help() {
    cat <<EOF
Usage: dotpy <command> <args>

  Utility for managing Python virtual environments.

  Note: the 'make' command uses 'virtualenv' and accepts all the same
  arguments as that tool.

Commands:

  activate <name>       Activate the named virtual environment.
  deactivate            Deactivate the current virtual environment.
  help                  Print this help message and exit.
  list                  List all virtual environments.
  make <name>           Make a new virtual environment.
  remove <names>        Delete one or more virtual environments.

Environments:

EOF
    echo -n "  " && /bin/ls -m $DOTPYENVS
}

# Public interface for the suite of utility functions.
function dotpy() {
    if [[ -n "$1" ]]; then
        local command="$1"
        shift
        case "$command" in
            a|activate)
                dotpy-activate "$@";;
            d|deactivate)
                deactivate;;
            h|help|--help)
                dotpy-help;;
            l|ls|list)
                dotpy-list "$@";;
            m|mk|make)
                dotpy-make "$@";;
            r|rm|remove)
                dotpy-remove "$@";;
            *)
                dotpy-activate "$command" "$@";;
        esac
    else
        dotpy-help
    fi
}
