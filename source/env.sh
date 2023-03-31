# ------------------------------------------------------------------------------
# Environment variables.
# ------------------------------------------------------------------------------

# export _Z_CMD="jump"
export _Z_DATA="$HOME/.cache/zdata"

export EDITOR="vim"
export LESS="--tabs=4 -RFX"

if test -d "$HOME/.env"; then
    pushd "$HOME/.env" > /dev/null
    for file in *.auto.sh; do
        if test -e "$file"; then
            source "$file"
            export "DOT_ENV_LOADED_${file%.auto.sh}"="true"
        fi
    done
    popd > /dev/null
fi
