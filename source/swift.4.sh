# ------------------------------------------------------------------------------
# Swift environment settings.
# ------------------------------------------------------------------------------

# Source Swift completion.
if is_installed swift; then
	eval "`swift package completion-tool generate-bash-script`"
fi
