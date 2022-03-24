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
        vay)
            cd ~/dev/vay;;
        vim)
            cd ~/.vim;;
        *)
            jj "$@";;
    esac
}
