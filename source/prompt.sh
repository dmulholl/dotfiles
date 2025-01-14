# ------------------------------------------------------------------------------
# Set the command prompt.
#
# Note that escaped square brackets \[ and \] are used to enclose sequences
# of non-printing characters. This stops Bash getting confused about the
# actual length of the prompt.
# ------------------------------------------------------------------------------

# Prints the name of the current git branch.
dot_print_git_branch_name() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# Prints '*' if the current git branch is dirty.
dot_print_git_is_dirty() {
    [[ -n $(git status --porcelain 2> /dev/null) ]] && echo "*"
}

# Prints metadata about the current shell environment.
dot_print_prompt_meta() {
    # The exit code from the last process.
    echo -n "[$?"

    # The name of the current Python virtual environment.
    if test ! -z "$CONDA_PREFIX"; then
        echo -n ":conda($(basename $CONDA_DEFAULT_ENV))"
    elif test ! -z $VIRTUAL_ENV; then
        echo -n ":$(basename $VIRTUAL_ENV)"
    fi

    # The current git branch name.
    local branch_name="$(dot_print_git_branch_name)"
    local is_dirty="$(dot_print_git_is_dirty)"

    if test ! -z "$branch_name"; then
        echo -n ":${branch_name}${is_dirty}"
    fi

    echo -n "]"
}

# Prints user@host or an abbreviated version for known systems.
dot_print_prompt_user() {
    local user_name="$USER"
    local host_name=$(hostname -s | tr '[:upper:]' '[:lower:]')

    if [[ $host_name == vay* ]]; then
        echo "(vay)"
    elif [[ $host_name == "mbp16" && $user_name == "dmulholl" ]]; then
        echo "(mbp16)"
    elif [[ $host_name == "mbp14" && $user_name == "dmulholl" ]]; then
        echo "(mbp14)"
    elif [[ $host_name == ip* ]]; then
        echo "(vpn)"
    else
        echo "$user_name@$host_name"
    fi
}

# Prints the number of jobs currently in the background.
dot_print_num_background_jobs() {
    jobs -p | wc -l | tr -d " "
}

# Prints 'n>' where n is the number of background jobs, or '>>' if n is zero.
dot_print_prompt_arrows() {
    # The number of jobs is always 1 too many when the function runs inside the prompt.
    if [[ "$(dot_print_num_background_jobs)" -gt "1" ]]; then
        echo -n "$(($(dot_print_num_background_jobs) - 1))>"
    else
        echo -n ">>"
    fi
}

# Moves the cursor into the correct position to overwrite the blank (--:--) time template.
# - For single-line commands, we allow for line-wrapping.
# - For multi-line commands, we make a best effort and ignore the possibility of line-wrapping.
dot_move_to_start_of_ps1() {
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

dot_short_prompt="
\[$fgc_green\]\u \[$fgc_yellow\]\w
\[$fgc_yellow\] \$(dot_print_prompt_arrows) \[$fgc_default\]"

dot_default_prompt="
\[$fgc_magenta\]\$(dot_print_prompt_meta) \[$fgc_green\]$(dot_print_prompt_user) \[$fgc_yellow\]\w
\[$fgc_yellow\] \$(dot_print_prompt_arrows) \[$fgc_default\]"

dot_linux_prompt="
\[$fgc_magenta\]\$(dot_print_prompt_meta) \[$fgc_blue\]$(dot_print_prompt_user) \[$fgc_yellow\]\w
\[$fgc_yellow\] \$(dot_print_prompt_arrows) \[$fgc_default\]"

dot_long_prompt="
\[$fgc_magenta\]\$(dot_print_prompt_meta) \[$fgc_green\]\u@\h \[$fgc_yellow\]\w
\[$fgc_yellow\] \$(dot_print_prompt_arrows) \[$fgc_default\]"

dot_time_prompt="
\[$fgc_magenta\](--:--) \$(dot_print_prompt_meta) \[$fgc_green\]$(dot_print_prompt_user) \[$fgc_yellow\]\w
\[$fgc_yellow\] \$(dot_print_prompt_arrows) \[$fgc_default\]"

# Bash expands and displays PS0 after it reads a command but before executing it.
# This PS0 saves the cursor position, jumps up and overwrites the time placeholder,
# then jumps back to the saved position.
dot_set_prompt_time="\$(tput sc)\$(dot_move_to_start_of_ps1)\[$fgc_magenta\](\A)\[$fgc_default\]\$(tput rc)"

# This is the continuation prompt for multi-line commands.
export PS2="\[$fgc_yellow\] >> \[$fgc_default\]"

dot_prompt_help() {
    cat <<EOF
Usage: dot prompt <style>

  Sets the prompt style.

Flags:
  -h, --help    Prints this help message.

Styles:
  - default
  - linux
  - short/simple
  - long/user/username
  - time
EOF
}

dot_prompt() {
    local cmd="$1"
    shift
    case "$cmd" in
        -h|--help)
            dot_prompt_help
            ;;
        ""|default)
            export PS0=""
            export PS1="$dot_default_prompt"
            ;;
        short|simple)
            export PS0=""
            export PS1="$dot_short_prompt"
            ;;
        linux)
            export PS0=""
            export PS1="$dot_linux_prompt"
            ;;
        long|user|username)
            export PS0=""
            export PS1="$dot_long_prompt"
            ;;
        time)
            export PS0="$dot_set_prompt_time"
            export PS1="$dot_time_prompt"
            ;;
        *)
            dot_prompt_help
            ;;
    esac
}

export PS0=""
export PS1="$dot_default_prompt"

if is_linux; then
    export PS1="$dot_linux_prompt"
fi

if is_executable direnv; then
    eval "$(direnv hook bash)"
fi
