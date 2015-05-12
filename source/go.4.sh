
# ----------------------------------------------------------------------------
# Go
# ----------------------------------------------------------------------------

if type go &> /dev/null; then
    is_init && e_check " .. Go installation found"
    export GOROOT=`go env GOROOT`
    export GOPATH=~/dev/go
else
    is_init && e_error " .. no Go installation found"
fi
