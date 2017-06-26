# --------------------------------------------------------------------------
# Set the command prompt.
#
# Note that escaped square brackets \[ and \] are used to enclose sequences
# of non-printing characters. This stops Bash getting confused about the
# actual length of the prompt.
# --------------------------------------------------------------------------

# Echo the currently active Python virtual environment.
function prompt_virtualenv() {
    if test -n "$VIRTUAL_ENV"; then
        echo "[$(basename $VIRTUAL_ENV)] "
    fi
}

# Prompt for use on Mac.
mac_prompt="
\[$magenta\]\$(prompt_virtualenv)\[$green\]\u@\h \[$yellow\]\w
\[$resetclrs\]\!: \$ "

# Prompt for use on Linux.
lnx_prompt="
\[$magenta\]\$(prompt_virtualenv)\[$blue\]\u@\h \[$yellow\]\w
\[$resetclrs\]\!: \$ "

# Export the appropriate prompt.
if is_mac; then
    export PS1=$mac_prompt
elif is_linux; then
    export PS1=$lnx_prompt
fi
