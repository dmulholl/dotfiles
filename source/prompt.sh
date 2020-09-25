# ------------------------------------------------------------------------------
# Set the command prompt.
#
# Note that escaped square brackets \[ and \] are used to enclose sequences
# of non-printing characters. This stops Bash getting confused about the
# actual length of the prompt.
# ------------------------------------------------------------------------------

# Print the name of the current git branch.
print_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# Print '*' if the current git branch is dirty.
print_git_dirty() {
    [[ -z $(git status --porcelain 2> /dev/null) ]] || echo "*"
}

# Print the exit code from the last process, the python virtual environment,
# and git branch name and status.
print_prompt_data() {
    echo -n "[$?"

    # Python enviroment.
    if [ $CONDA_PREFIX ]; then
        echo -n ":conda($(basename $CONDA_DEFAULT_ENV))"
    elif [ $VIRTUAL_ENV ]; then
        echo -n ":dotpy($(basename $VIRTUAL_ENV))"
    fi

    # Git branch name.
    local branch=$(print_git_branch)
    local dirty=$(print_git_dirty)
    [ $branch ] && echo -n ":${branch}${dirty}"

    echo -n "]"
}

move_to_start_of_ps1() {
    command_rows=$(history 1 | wc -l)
    if [ "$command_rows" -gt 1 ]; then
        let vertical_movement="$command_rows + 1"
    else
        command=$(history 1 | sed 's/^  [0-9]*  //' | cut -c 15-)
        command_length=${#command}
        ps1_prompt_length=${#PS1_PROMPT}
        let total_length="$command_length + $ps1_prompt_length"
        let lines="$total_length / ${COLUMNS} + 1"
        let vertical_movement="$lines + 1"
    fi
    tput cuu $vertical_movement
}

simple_prompt="
\[$fgc_magenta\](--:--) \[$fgc_green\]\u \[$fgc_yellow\]\w
\[$fgc_yellow\] >> \[$fgc_default\]"

mac_prompt="
\[$fgc_magenta\](--:--) \$(print_prompt_data) \[$fgc_green\]\u@\h \[$fgc_yellow\]\w
\[$fgc_yellow\] >> \[$fgc_default\]"

linux_prompt="
\[$fgc_magenta\](--:--) \$(print_prompt_data) \[$fgc_blue\]\u@\h \[$fgc_yellow\]\w
\[$fgc_yellow\] >> \[$fgc_default\]"

# Bash expands and displays PS0 after it reads a command but before executing it.
# This PS0 saves the cursor position, jumps up and overwrites the time placeholder,
# then jumps back to the saved position.
export PS0="\$(tput sc)\$(move_to_start_of_ps1)\[$fgc_magenta\](\A)\[$fgc_default\]\$(tput rc)"

export PS2="\[$fgc_yellow\] >> \[$fgc_default\]"

if is_linux; then
    export PS1="$linux_prompt"
else
    export PS1="$mac_prompt"
fi
