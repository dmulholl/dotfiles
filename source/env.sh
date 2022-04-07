# ------------------------------------------------------------------------------
# Environment variables.
# ------------------------------------------------------------------------------

export LESS="--tabs=4 -RFX"
export FZF_DEFAULT_COMMAND="rg --files --no-ignore -g '!out/'"
export _Z_CMD="jj"
export _Z_DATA="$HOME/.cache/zdata"
export EDITOR="vim"

if test -d "$HOME/.env"; then
    for file in "$HOME/.env/*.auto.sh"; do
        test -e "$file" && source "$file"
    done
fi
