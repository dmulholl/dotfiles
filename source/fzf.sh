# ------------------------------------------------------------------------------
# FZF settings.
# ------------------------------------------------------------------------------

# Set up fzf key bindings and fuzzy completion
if is_executable fzf; then
    eval "$(fzf --bash)"
fi

# I think the goal here was just to exclude the content of the 'out' directory.
# export FZF_DEFAULT_COMMAND="rg --files --no-ignore -g '!out/'"
