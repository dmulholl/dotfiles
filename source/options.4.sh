
# ----------------------------------------------------------------------------
# Shell Options
# ----------------------------------------------------------------------------

# Autocorrect typos in path names when using `cd`.
shopt -s cdspell

# Glob patterns with no matches should expand to a null string, not themselves.
shopt -s nullglob

# Allow the ** pattern when globbing. Requires Bash 4.
shopt -s globstar 2> /dev/null || is_init && e_error " .. globstar option not supported"

# Automatically cd into bare directory names. Requires Bash 4.
shopt -s autocd 2> /dev/null || is_init && e_error " .. autocd option not supported"
