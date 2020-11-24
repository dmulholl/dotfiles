# ------------------------------------------------------------------------------
# Shell history settings.
# ------------------------------------------------------------------------------

# Append to the history file on shell exit rather than overwriting it.
shopt -s histappend

# Verify a command before running it.
shopt -s histverify

# Don't add matching entries to the history file.
export HISTIGNORE=$'?:??:???:exit:history'

# Ignore commands starting with a space; ignore sequential duplicates.
export HISTCONTROL="ignorespace:ignoredups"

# Add a timestamp to history entries.
export HISTTIMEFORMAT="%h %d %H:%M  "

# More history.
export HISTSIZE=1024
export HISTFILESIZE=4096
