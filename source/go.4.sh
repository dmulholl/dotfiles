# --------------------------------------------------------------------------
# Go
# --------------------------------------------------------------------------

if is_installed go; then
    export GOROOT=`go env GOROOT`
    export GOPATH=~/dev
else
    [[ $verbose ]] && df_arrow " .. no Go installation found"
fi
