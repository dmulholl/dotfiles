# ------------------------------------------------------------------------------
# Python settings.
# ------------------------------------------------------------------------------

# Stop fucking with my prompt.
export VIRTUAL_ENV_DISABLE_PROMPT=true

# Require a virtual environment to be active for pip to function.
export PIP_REQUIRE_VIRTUALENV=true

# Storage location for virtual environments.
export DOT_PYENVS=~/.dotpyenvs

dot_pyenv_help() {
    cat <<EOF
Usage: dot pyenv <command>

  A utility for managing Python virtual environments.

  To activate a virtual environment run one of:
    dot pyenv activate <name>
    dot pyenv <name>

  To deactivate the current virtual environment run one of:
    dot pyenv deactivate
    deactivate

  To create a new virtual environment run:
    dot pyenv make <name>

Commands:
  a, activate <name>    Activate the named virtual environment.
  d, deactivate         Deactivate the current virtual environment.
  x, delete <names>     Delete one or more virtual environments.
  m, make <name>        Make a new virtual environment.

Flags:
  -h, --help            Display this help text and exit.

Environments:
EOF
echo -n "  " && /bin/ls -m $DOT_PYENVS
}

dot_pyenv() {
    local arg="$1"
    shift

    case "$arg" in
        ""|-h|--help)
            dot_pyenv_help
            ;;
        a|activate)
            dot_pyenv_activate "$@"
            ;;
        d|deactivate)
            deactivate
            ;;
        m|make)
            dot_pyenv_make "$@"
            ;;
        x|delete)
            dot_pyenv_delete "$@"
            ;;
        *)
            dot_pyenv_activate "$arg"
            ;;
    esac
}

dot_pyenv_activate() {
    if [[ -z "$1" ]]; then
        echo "Error: missing name argument."
        return 1
    fi

    local name="$1"
    local script="$DOT_PYENVS/$name/bin/activate"

    if [[ -e $script ]]; then
        source $script
    else
        echo "Error: no virtual environment named '$name'."
        return 1
    fi
}

dot_pyenv_make() {
    if [[ -z "$1" ]]; then
        echo "Error: missing name argument."
        return 1
    fi

    local name="$1"
    local path=$DOT_PYENVS/$name

    if [[ -d $path ]]; then
        echo "Error: '$name' already exists."
        return 1
    fi

    if is_command deactivate; then
        deactivate
    fi

    if [[ ! -d $DOT_PYENVS ]]; then
        mkdir -p $DOT_PYENVS
    fi

    if ! is_executable python3; then
        echo "Error: python3 is not available."
        return 1
    fi

    which python3
    python3 --version
    python3 -m venv --copies --upgrade-deps $path && dot_pyenv_activate $name
}

dot_pyenv_delete() {
    if [[ $# -eq 0 ]]; then
        echo "Error: missing name argument(s)."
        return 1
    fi

    for name in "$@"; do
        local path=$DOT_PYENVS/$name
        if [[ -d $path ]]; then
            rm -rf $path
        else
            echo "Error: no virtual environment named '$name'."
            return 1
        fi
    done
}
