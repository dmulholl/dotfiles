# ------------------------------------------------------------------------------
# Enable the bash-completion plugin.
# ------------------------------------------------------------------------------

# MacPorts installation: sudo port install bash-completion
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi
