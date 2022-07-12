# ------------------------------------------------------------------------------
# Python settings.
# ------------------------------------------------------------------------------

# Stop fucking with my prompt.
export VIRTUAL_ENV_DISABLE_PROMPT=true

# Require a virtual environment to be active for pip to function.
export PIP_REQUIRE_VIRTUALENV=true

# Storage location for virtual environments.
export DOT_PY_ENVS=~/.pyenvs


function dotpy_help {
    cat <<EOF
Usage: dotpy <command>

  A utility for managing Python virtual environments.

  To activate a virtual environment, run:

    dotpy activate <name>

  Or, as a shortcut, just specify the name:

    dotpy <name>

  To deactivate the current virtual environment run:

    dotpy deactivate

  Or simply:

    deactivate

Commands:
  activate <name>    Activate the named virtual environment.
  deactivate         Deactivate the current virtual environment.
  delete <names>     Delete one or more virtual environments.
  make <name>        Make a new virtual environment.

Environments:
EOF
    echo -n "  " && /bin/ls -m $DOT_PY_ENVS
}


function dotpy {
    if [[ -n "$1" ]]; then
        local arg="$1"
        shift
        case "$arg" in
            a|activate)
                dotpy_activate "$@";;
            d|deactivate)
                deactivate;;
            -h|--help)
                dotpy_help;;
            m|make)
                dotpy_make "$@";;
            del|delete)
                dotpy_delete "$@";;
            *)
                dotpy_activate "$arg";;
        esac
    else
        dotpy_help
    fi
}


function dotpy_activate {
    if [[ -z "$1" ]]; then
        echo "Error: missing name argument."
        return 1
    fi

    local name="$1"
    local script="$DOT_PY_ENVS/$name/bin/activate"

    if [[ -e $script ]]; then
        source $script
    else
        echo "Error: no virtual environment named '$name'."
        return 1
    fi
}


function dotpy_try_activate {
    local script=$DOT_PY_ENVS/$1/bin/activate
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
    local path=$DOT_PY_ENVS/$name

    if [[ -d $path ]]; then
        echo "Error: '$name' already exists."
        return 1
    fi

    if is_available deactivate; then
        deactivate
    fi

    if [[ ! -d $DOT_PY_ENVS ]]; then
        mkdir -p $DOT_PY_ENVS
    fi

    which python
    python --version
    python -m venv $path && dotpy_activate $name
}


function dotpy_delete {
    if [[ $# -eq 0 ]]; then
        echo "Error: missing name argument(s)."
        return 1
    fi

    for name in "$@"; do
        local path=$DOT_PY_ENVS/$name
        if [[ -d $path ]]; then
            rm -rf $path
        else
            echo "Error: no virtual environment named '$name'."
            return 1
        fi
    done
}
