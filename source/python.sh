# ------------------------------------------------------------------------------
# Python settings.
# ------------------------------------------------------------------------------

# Add this directory to Python's import path.
export PYTHONPATH=~/dev/lib/python

# Disable the default virtualenv prompt.
export VIRTUAL_ENV_DISABLE_PROMPT=true

# Require a virtual environment to be active for pip to function.
# To use pip outside a virtual environment run:
#
#     PIP_REQUIRE_VIRTUALENV="" pip
#
export PIP_REQUIRE_VIRTUALENV=true

export DOTPYENVS=~/.pyenvs

function dotpy_help {
    cat <<EOF
Usage: dotpy <command> <args>

  Utility for managing Python virtual environments.

Commands:

  a, activate <name>    Activate the named virtual environment.
  d, deactivate         Deactivate the current virtual environment.
     delete <names>     Delete one or more virtual environments.
  m, make <name>        Make a new virtual environment.

Environments:

EOF
    echo -n "  " && /bin/ls -m $DOTPYENVS
}

function dotpy {
    if [[ -n "$1" ]]; then
        local command="$1"
        shift
        case "$command" in
            a|activate)
                dotpy_activate "$@";;
            d|deactivate)
                deactivate;;
            h|help|--help)
                dotpy_help;;
            m|make)
                dotpy_make "$@";;
            del|delete)
                dotpy_remove "$@";;
            *)
                dotpy_activate "$command" "$@";;
        esac
    else
        dotpy_help
    fi
}

function dotpy_activate {
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

function dotpy_try_activate {
    local script=$DOTPYENVS/$1/bin/activate
    if [[ -e $script ]]; then
        source $script
    fi
}

function dotpy_make {
    if [[ -z "$1" ]]; then
        echo "Error: missing name argument."
        return 1
    fi

    local name="$1"
    local path=$DOTPYENVS/$name

    if [[ -d $path ]]; then
        echo "Error: '$name' already exists."
        return 1
    fi

    if is_installed deactivate; then
        deactivate
    fi

    if [[ ! -d $DOTPYENVS ]]; then
        mkdir -p $DOTPYENVS
    fi

    which python
    python --version
    python -m venv $path && dotpy_activate $name
}

function dotpy_remove {
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

