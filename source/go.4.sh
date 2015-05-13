
# ----------------------------------------------------------------------------
# Go
# ----------------------------------------------------------------------------

if is_installed go; then
    export GOROOT=`go env GOROOT`
    export GOPATH=~/dev/go
else
    [[ $verbose ]] && e_error " .. no Go installation found"
fi
