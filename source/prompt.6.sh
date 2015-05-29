
# -------------------------------------------------------------------------
# Prompt
# -------------------------------------------------------------------------

# Echo the currently active Python virtual environment.
function prompt_virtualenv() {
    if [ -n "$VIRTUAL_ENV" ]; then
        echo "($(basename $VIRTUAL_ENV)) "
    fi
}

# Set the window title.
title "$USER@$HOSTNAME"

# Set the prompt.
export PS1="
\[$purple\]\$(prompt_virtualenv)\[$green\]\u@\h \[$yellow\]\w
\[$normal\]\!: \$ "
