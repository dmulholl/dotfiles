# ------------------------------------------------------------------------------
# Set the command prompt.
#
# Note that escaped square brackets \[ and \] are used to enclose sequences
# of non-printing characters. This stops Bash getting confused about the
# actual length of the prompt.
#
# Prompt options:  |▶  |►  |▸  |▷  $|  $:
# ------------------------------------------------------------------------------

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

prompt_data() {
    echo -n "[$?"

    # Active Python virtual environment.
    [ $VIRTUAL_ENV ] && echo -n ":$(basename $VIRTUAL_ENV)"

    # Git branch name.
    # local branch=$(git branch 2> /dev/null | grep '^*' | colrm 1 2)
    local branch=$(parse_git_branch)
    [ $branch ] && echo -n ":$branch"

    echo -n "]"
}

termtitle="\[\e]0;\w\a\]"

prompt="$termtitle
\[$magenta\]\$(prompt_data) \[$green\]\u@\h \[$yellow\]\w
\[$magenta\] \$: \[$resetclrs\]"

export PS1=$prompt
