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
print_git_is_dirty() {
    [[ -z $(git status --porcelain 2> /dev/null) ]] || echo "*"
}

# Print metadata about the current shell environment.
print_prompt_meta() {
    echo -n "["

    # The exit code from the last process.
    echo -n "$?"

    # The name of the current Python virtual environment.
    if [ $CONDA_PREFIX ]; then
        echo -n ":conda($(basename $CONDA_DEFAULT_ENV))"
    elif [ $VIRTUAL_ENV ]; then
        echo -n ":$(basename $VIRTUAL_ENV)"
    fi

    # The current git branch name.
    local branch_name=$(print_git_branch)
    local is_dirty=$(print_git_is_dirty)
    [ $branch_name ] && echo -n ":${branch_name}${is_dirty}"

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

# Prints the number of jobs currently in the background.
print_num_jobs() {
    jobs -p | wc -l | tr -d " "
}

# Prints 'n>' where n is the number of background jobs, or '>>' if n is zero.
print_arrows() {
    # The number of jobs is always 1 too many when the function runs inside the prompt.
    if [[ "$(print_num_jobs)" -gt "1" ]]; then
        echo -n "$(($(print_num_jobs) - 1))>"
    else
        echo -n ">>"
    fi
}

print_prompt_user() {
    username="$USER"
    hostname=$(hostname -s | tr '[:upper:]' '[:lower:]')

    if [[ $hostname == vay* ]]; then
        echo "(vay)"
    elif [[ $hostname == "mbp16" && $username == "dmulholl" ]]; then
        echo "(mbp16)"
    else
        echo "$username@$hostname"
    fi
}

short_prompt="
\[$fgc_magenta\](--:--) \[$fgc_green\]\u \[$fgc_yellow\]\w
\[$fgc_yellow\] \$(print_arrows) \[$fgc_default\]"

default_prompt="
\[$fgc_magenta\](--:--) \$(print_prompt_meta) \[$fgc_green\]$(print_prompt_user) \[$fgc_yellow\]\w
\[$fgc_yellow\] \$(print_arrows) \[$fgc_default\]"

long_prompt="
\[$fgc_magenta\](--:--) \$(print_prompt_meta) \[$fgc_green\]\u@\h \[$fgc_yellow\]\w
\[$fgc_yellow\] \$(print_arrows) \[$fgc_default\]"

# Bash expands and displays PS0 after it reads a command but before executing it.
# This PS0 saves the cursor position, jumps up and overwrites the time placeholder,
# then jumps back to the saved position.
export PS0="\$(tput sc)\$(move_to_start_of_ps1)\[$fgc_magenta\](\A)\[$fgc_default\]\$(tput rc)"

# This is the continuation prompt for multi-line commands.
export PS2="\[$fgc_yellow\] \$(print_arrows) \[$fgc_default\]"

function prompt_help {
    cat <<EOF
Usage: prompt <style>

  Sets the prompt style.

Styles:
  - short/simple
  - default
  - long/user/username
EOF
}

function prompt {
    if [[ -n "$1" ]]; then
        local command="$1"
        shift
        case "$command" in
            -h|--help)
                prompt_help;;
            short|simple)
                export PS1="$short_prompt";;
            default)
                export PS1="$default_prompt";;
            long|user|username)
                export PS1="$long_prompt";;
            *)
                prompt_help;;
        esac
    else
        export PS1="$default_prompt"
    fi
}

export PS1="$default_prompt"
