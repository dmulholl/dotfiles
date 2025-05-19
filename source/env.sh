# ------------------------------------------------------------------------------
# Environment variables.
# ------------------------------------------------------------------------------

if test -d "$HOME/.dotlocal/env"; then
    pushd "$HOME/.dotlocal/env" > /dev/null
    for file in *.auto.sh; do
        if test -e "$file"; then
            source "$file"
            export "DOT_ENV_LOADED_${file%.auto.sh}"="true"
        fi
    done
    popd > /dev/null
fi

export _Z_DATA="$HOME/.cache/zdata"
export EDITOR="vim"
export LESS="--tabs=4 -RFX"

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_EMOJI=1
