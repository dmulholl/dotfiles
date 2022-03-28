# ------------------------------------------------------------------------------
# Jump places.
# ------------------------------------------------------------------------------

function j() {
    case "$1" in
        bin)
            cd ~/dev/bin;;
        dev)
            cd ~/dev;;
        dm)
            cd ~/dev/web/dmulholl.com;;
        notes)
            cd ~/dev/notes;;
        src)
            cd ~/dev/src;;
        tmp)
            cd ~/dev/tmp;;
        vay)
            cd ~/dev/vay;;
        vim)
            cd ~/.vim;;
        *)
            jj "$@";;
    esac
}
