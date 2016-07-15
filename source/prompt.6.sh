# --------------------------------------------------------------------------
# Prompt
# --------------------------------------------------------------------------

# Echo the currently active Python virtual environment.
function prompt_virtualenv() {
    if [ -n "$VIRTUAL_ENV" ]; then
        echo "[$(basename $VIRTUAL_ENV)] "
    fi
}

# Prompt for use on Macs.
prompt_mac="
\[$magenta\]\$(prompt_virtualenv)\[$green\]\u@\h \[$yellow\]\w
\[$reset\]\!: \$ "

# Prompt for use on Linux.
prompt_linux="
\[$magenta\]\$(prompt_virtualenv)\[$blue\]\u@\h \[$yellow\]\w
\[$reset\]\!: \$ "

# Export the appropriate prompt.
if is_mac; then
    export PS1=$prompt_mac
fi

if is_linux; then
    export PS1=$prompt_linux
fi
