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

parse_git_dirty() {
    [[ -z $(git status --porcelain 2> /dev/null) ]] || echo "*"
}

prompt_data() {
    echo -n "[$?"

    # Python enviroment.
    if [ $CONDA_PREFIX ]; then
        echo -n ":conda($(basename $CONDA_DEFAULT_ENV))"
    elif [ $VIRTUAL_ENV ]; then
        echo -n ":dotpy($(basename $VIRTUAL_ENV))"
    fi

    # Git branch name.
    local branch=$(parse_git_branch)
    local dirty=$(parse_git_dirty)
    [ $branch ] && echo -n ":${branch}${dirty}"

    echo -n "]"
}

termtitle="\[\e]0;\w\a\]"

prompt="$termtitle
\[$magenta\]\$(prompt_data) \[$green\]\u@\h \[$yellow\]\w
\[$magenta\] \$: \[$resetclrs\]"

export PS1=$prompt
