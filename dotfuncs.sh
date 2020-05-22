# ------------------------------------------------------------------------------
# Admin functions for the `dot` command.
# ------------------------------------------------------------------------------

function dot() {
    case "$1" in
        update)
            dot_update;;
        init)
            dot_init;;
        source|src)
            dot_source;;
        link)
            dot_link;;
        *)
            dot_help;;
    esac
}

# Print the help text for the dotfiles command.
function dot_help() {
    cat <<EOF
Usage: dot <command>

  Dotfiles management utility. To update the installation,  first update
  the local .dotfiles git repository, then run `dot init`.

Commands:
  init      Initialize/reinitialize the installation.
  link      Link all files in ~/.dotfiles/link into ~/.
  src       Source all files in ~/.dotfiles/source.
EOF
}

# Source all files in /source.
function dot_source() {
    source ~/.dotfiles/source/colours.sh
    source ~/.dotfiles/source/functions.sh
    source ~/.dotfiles/source/options.sh
    source ~/.dotfiles/source/path.sh
    source ~/.dotfiles/source/aliases.sh
    source ~/.dotfiles/source/env.sh
    source ~/.dotfiles/source/go.sh
    source ~/.dotfiles/source/history.sh
    source ~/.dotfiles/source/python.sh
    source ~/.dotfiles/source/swift.sh
    source ~/.dotfiles/source/z.sh
    source ~/.dotfiles/source/prompt.sh
}

# Create a symlink in $HOME to each file or directory in /link.
function dot_link() {
    for targetfile in ~/.dotfiles/link/*; do
        linkfile=~/.$(basename $targetfile)
        if test -e $linkfile; then
            if test -L $linkfile; then
                rm $linkfile
            else
                mv $linkfile dotbackup$linkfile
            fi
        fi
        ln -svf $targetfile $linkfile
    done
}

# Initialize/reinitialize the dotfiles installation.
function dot_init() {
    source ~/.dotfiles/dotfuncs.sh
    dot_source
    dot_link
}
