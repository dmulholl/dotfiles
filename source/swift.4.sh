# ------------------------------------------------------------------------------
# Swift environment settings.
# ------------------------------------------------------------------------------

# Source Swift completion.
if [ -n "`which swift`" ]; then
	eval "`swift package completion-tool generate-bash-script`"
fi
