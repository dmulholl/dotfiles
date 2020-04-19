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

move_cursor_to_start_of_ps1() {
    command_rows=$(history 1 | wc -l)
    if [ "$command_rows" -gt 1 ]; then
        let vertical_movement="$command_rows + 1"
    else
        command=$(history 1 | sed 's/^\s*[0-9]*\s*//')
        command_length=${#command}
        ps1_prompt_length=${#PS1_PROMPT}
        let total_length="$command_length + $ps1_prompt_length"
        let lines="$total_length / ${COLUMNS} + 1"
        let vertical_movement="$lines + 1"
    fi
    tput cuu $vertical_movement
}

set_termtitle="\[\e]0;\w\a\]"

export PS0="\$(tput sc)\$(move_cursor_to_start_of_ps1)\[$fgc_magenta\][\A]\[$fgc_default\]\$(tput rc)"

export PS1="$set_termtitle
\[$fgc_magenta\][--:--] \$(print_prompt_data) \[$fgc_green\]\u@\h \[$fgc_yellow\]\w
\[$fgc_yellow\] >> \[$fgc_default\]"

export PS2="\[$fgc_yellow\] >> \[$fgc_default\]"
