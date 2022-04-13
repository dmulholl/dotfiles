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
    # [[ -z $(git status --porcelain 2> /dev/null) ]] || echo "*"
    [[ -n $(git status --porcelain 2> /dev/null) ]] && echo "*"
}

# Print metadata about the current shell environment.
print_prompt_meta() {
    # The exit code from the last process.
    echo -n "[$?"

    # The name of the current Python virtual environment.
    if test ! -z "$CONDA_PREFIX"; then
        echo -n ":conda($(basename $CONDA_DEFAULT_ENV))"
    elif test ! -z $VIRTUAL_ENV; then
        echo -n ":$(basename $VIRTUAL_ENV)"
    fi

    # The current git branch name.
    local branch_name="$(print_git_branch)"
    local is_dirty="$(print_git_is_dirty)"

    if test ! -z "$branch_name"; then
        echo -n ":${branch_name}${is_dirty}"
    fi

    echo -n "]"
}

# This command moves the cursor into the correct position to overwrite the blank (--:--) time
# template.
# - For single-line commands, we allow for line-wrapping.
# - For multi-line commands, we make a best effort and ignore the possibility of line-wrapping.
move_to_start_of_ps1() {
    local num_lines_in_last_command=$(history 1 | wc -l)

    if [ $num_lines_in_last_command -gt 1 ]; then
        local lines_to_move=$(($num_lines_in_last_command + 1))
    else
        local last_command=$(history 1 | sed 's/^  [0-9]*  //' | cut -c 15-)
        local last_command_length=${#last_command}
        local ps1_prompt_length=${#PS1_PROMPT}
        local total_length=$(($last_command_length + $ps1_prompt_length))
        local num_lines=$(($total_length / ${COLUMNS} + 1))
        local lines_to_move=$(($num_lines + 1))
    fi

    tput cuu $lines_to_move
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
    local user_name="$USER"
    local host_name=$(hostname -s | tr '[:upper:]' '[:lower:]')

    if [[ $host_name == vay* ]]; then
        echo "(vay)"
    elif [[ $host_name == "mbp16" && $user_name == "dmulholl" ]]; then
        echo "(mbp16)"
    else
        echo "$user_name@$host_name"
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
export PS2="\[$fgc_yellow\] >> \[$fgc_default\]"

prompt_help() {
    cat <<EOF
Usage: prompt <style>

  Sets the prompt style.

Styles:
  - short/simple
  - default
  - long/user/username
EOF
}

prompt() {
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
