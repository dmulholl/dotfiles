
# -------------------------------------------------------------------------
# Go
# -------------------------------------------------------------------------

if is_installed go; then
    export GOROOT=`go env GOROOT`
    export GOPATH=~/dev
else
    [[ $verbose ]] && df_error " .. no Go installation found"
fi
