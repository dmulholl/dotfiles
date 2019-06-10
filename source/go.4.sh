# ------------------------------------------------------------------------------
# Go environment settings.
# ------------------------------------------------------------------------------

if is_installed go; then
    export GOROOT=`go env GOROOT`
    export GOPATH=$HOME/dev/go
fi
