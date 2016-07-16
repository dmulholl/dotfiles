# --------------------------------------------------------------------------
# System administration commands for OSX.
# --------------------------------------------------------------------------

# The 'mac' command provides the interface to the suite of utility scripts.
function mac() {
    if [[ -n "$1" ]]; then
        local command="$1"
        shift
        case "$command" in
            --help)
                mac-help
                ;;
            help)
                if [[ -n "$1" ]]; then
                    if [[ -f $DOTFILES/mac/$1 ]]; then
                        $DOTFILES/mac/$1 --help
                    else
                        echo "Error: '$1' is not a recognised command."
                        return 1
                    fi
                else
                    mac-help
                fi
                ;;
            *)
                if [[ -f $DOTFILES/mac/$command ]]; then
                    $DOTFILES/mac/$command $@
                else
                    echo "Error: '$command' is not a recognised command."
                    return 1
                fi
                ;;
        esac
    else
        mac-help
    fi
}

# Print the 'mac' command's help text.
function mac-help() {
    cat <<EOF
Usage: mac [FLAGS] COMMAND

  System administration utility for OSX.

Flags:
  --help        Print this help text and exit.

Commands:

EOF
    for name in $DOTFILES/mac/*; do
        echo "  ${name##*/}"
    done
}
