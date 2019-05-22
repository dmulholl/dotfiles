# ------------------------------------------------------------------------------
# Go environment settings.
# ------------------------------------------------------------------------------

if is_installed go; then
    export GOROOT=`go env GOROOT`
    export GOPATH=$HOME/dev/go
else
    [[ $verbose ]] && dot_arrow " .. no Go installation found"
fi
