# ------------------------------------------------------------------------------
# Environment variables.
# ------------------------------------------------------------------------------

export LESS="--tabs=4 -RFX"
export FZF_DEFAULT_COMMAND="rg --files --no-ignore -g '!out/'"
export _Z_CMD="jj"
export _Z_DATA="$HOME/.cache/zdata"
export EDITOR="vim"

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
