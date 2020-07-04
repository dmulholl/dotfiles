# ------------------------------------------------------------------------------
# Python settings.
# ------------------------------------------------------------------------------

# Custom library directories.
export PYTHONPATH=~/dev/lib/python

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

export DOTPYENVS=~/.cache/dotpyenvs

function dotpy-help() {
    cat <<EOF
Usage: dotpy <command> <args>

  Utility for managing Python virtual environments.

  * The 'make' command uses 'virtualenv' and accepts all the same arguments.
  * The 'make' command automatically uses the --always-copy flag.

Commands:

  activate, a <name>    Activate the named virtual environment.
  deactivate, d         Deactivate the current virtual environment.
  delete <names>        Delete one or more virtual environments.
  list                  List virtual environments.
  make <name>           Make a new virtual environment.

Environments:

EOF
    echo -n "  " && /bin/ls -m $DOTPYENVS
}

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
            delete)
                dotpy-remove "$@";;
            *)
                dotpy-activate "$command" "$@";;
        esac
    else
        dotpy-help
    fi
}

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

function dotpy-try-activate() {
    local script=$DOTPYENVS/$1/bin/activate
    if [[ -e $script ]]; then
        source $script
    fi
}

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

function dotpy-list() {
    /bin/ls -m $DOTPYENVS
}

