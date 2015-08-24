# --------------------------------------------------------------------------
# Prompt
# --------------------------------------------------------------------------

# Echo the currently active Python virtual environment.
function prompt_virtualenv() {
    if [ -n "$VIRTUAL_ENV" ]; then
        echo "[$(basename $VIRTUAL_ENV)] "
    fi
}

# Default prompt colours.
venvcolour=$magenta
usercolour=$green
pathcolour=$yellow

# Prompt colours on Linux.
if is_linux; then
    usercolour=$blue
fi

# Set the window title.
title "$USER@$HOSTNAME"

# Set the prompt.
export PS1="
\[$venvcolour\]\$(prompt_virtualenv)\[$usercolour\]\u@\h \[$pathcolour\]\w
\[$reset\]\!: \$ "
