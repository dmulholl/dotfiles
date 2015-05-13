
# ----------------------------------------------------------------------------
# Go
# ----------------------------------------------------------------------------

if type go &> /dev/null; then
    [[ $verbose ]] && e_check " .. Go installation found"
    export GOROOT=`go env GOROOT`
    export GOPATH=~/dev/go
else
    [[ $verbose ]] && e_error " .. no Go installation found"
fi
