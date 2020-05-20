# ------------------------------------------------------------------------------
# Set shell options.
# ------------------------------------------------------------------------------

# Autocorrect typos in path names when using `cd`.
shopt -s cdspell

# Glob patterns with no matches should expand to a null string, not
# themselves. This breaks bash completion in Debian, including Ubuntu -.-
shopt -s nullglob

# Allow the ** pattern when globbing. Requires Bash 4.
shopt -s globstar 

# Automatically cd into bare directory names. Requires Bash 4.
shopt -s autocd 

# Recheck the window size after each command.
shopt -s checkwinsize
