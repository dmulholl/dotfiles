# ------------------------------------------------------------------------------
# Shell colour and formatting codes.
# ------------------------------------------------------------------------------

# Reset all attributes.
fmt_reset='\e[0m'

# Formatting.
fmt_bold='\e[1m'
fmt_dim='\e[2m'
fmt_underline='\e[4m'
fmt_blink='\e[5m'
fmt_hide='\e[8m'

# Foreground colour, default.
fgc_default='\e[39m'

# Foreground colours, normal.
fgc_black='\e[30m'
fgc_red='\e[31m'
fgc_green='\e[32m'
fgc_yellow='\e[33m'
fgc_blue='\e[34m'
fgc_magenta='\e[35m'
fgc_cyan='\e[36m'
fgc_white='\e[37m'

# Foreground colours, bright.
fgc_bblack='\e[90m'
fgc_bred='\e[91m'
fgc_bgreen='\e[92m'
fgc_byellow='\e[93m'
fgc_bblue='\e[94m'
fgc_bmagenta='\e[95m'
fgc_bcyan='\e[96m'
fgc_bwhite='\e[97m'

# Print a test set of colours.
function colours() {
    echo -e "${fgc_default}00 - ${fgc_black}\$fgc_black"
    echo -e "${fgc_default}01 - ${fgc_red}\$fgc_red"
    echo -e "${fgc_default}02 - ${fgc_green}\$fgc_green"
    echo -e "${fgc_default}03 - ${fgc_yellow}\$fgc_yellow"
    echo -e "${fgc_default}04 - ${fgc_blue}\$fgc_blue"
    echo -e "${fgc_default}05 - ${fgc_magenta}\$fgc_magenta"
    echo -e "${fgc_default}06 - ${fgc_cyan}\$fgc_cyan"
    echo -e "${fgc_default}07 - ${fgc_white}\$fgc_white"
    echo -e
    echo -e "${fgc_default}08 - ${fgc_bblack}\$fgc_bblack"
    echo -e "${fgc_default}09 - ${fgc_bred}\$fgc_bred"
    echo -e "${fgc_default}10 - ${fgc_bgreen}\$fgc_bgreen"
    echo -e "${fgc_default}11 - ${fgc_byellow}\$fgc_byellow"
    echo -e "${fgc_default}12 - ${fgc_bblue}\$fgc_bblue"
    echo -e "${fgc_default}13 - ${fgc_bmagenta}\$fgc_bmagenta"
    echo -e "${fgc_default}14 - ${fgc_bcyan}\$fgc_bcyan"
    echo -e "${fgc_default}15 - ${fgc_bwhite}\$fgc_bwhite"
    echo -en "${fgc_default}"
}
