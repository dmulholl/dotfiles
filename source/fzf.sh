# ------------------------------------------------------------------------------
# FZF settings.
# ------------------------------------------------------------------------------

# Set up fzf key bindings and fuzzy completion
if is_executable fzf; then
    eval "$(fzf --bash)"
fi
