# --------------------------------------------------------------------------
# History
# --------------------------------------------------------------------------

# Append to the history file on shell exit rather than overwriting it.
shopt -s histappend

# Don't add matching entries to the history file.
export HISTIGNORE=$'?:??:???:exit:hist:history'

# Ignore commands starting with a space; ignore sequential duplicates.
export HISTCONTROL="ignorespace:ignoredups"

# Add a timestamp to history entries.
export HISTTIMEFORMAT="%h %d %H:%M  "

# More history.
export HISTSIZE=9999
export HISTFILESIZE=9999
