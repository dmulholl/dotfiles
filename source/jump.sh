# ------------------------------------------------------------------------------
# Jump places.
# ------------------------------------------------------------------------------

function j() {
    case "$1" in
        dev)
            cd ~/dev;;
        src)
            cd ~/dev/src;;
        bin)
            cd ~/dev/bin;;
        dm)
            cd ~/dev/web/dmulholl.com;;
        vim)
            cd ~/.vim;;
        *)
            jj "$@";;
    esac
}
