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

# Foreground colours, normal.
fgc_black='\e[30m'
fgc_red='\e[31m'
fgc_green='\e[32m'
fgc_yellow='\e[33m'
fgc_blue='\e[34m'
fgc_magenta='\e[35m'
fgc_cyan='\e[36m'
fgc_white='\e[37m'
fgc_default='\e[39m'

# Background colours, normal.
bgc_black='\e[40m'
bgc_red='\e[41m'
bgc_green='\e[42m'
bgc_yellow='\e[43m'
bgc_blue='\e[44m'
bgc_magenta='\e[45m'
bgc_cyan='\e[46m'
bgc_white='\e[47m'
bgc_default='\e[49m'

# Print a test set of colours.
colours() {
    printf "0:  ${bgc_black}      ${bgc_default}${fgc_black}${fmt_bold}  bold${fmt_reset}${fgc_black}  normal${fmt_reset}  (black)\n"
    printf "1:  ${bgc_red}      ${bgc_default}${fgc_red}${fmt_bold}  bold${fmt_reset}${fgc_red}  normal${fmt_reset}  (red)\n"
    printf "2:  ${bgc_green}      ${bgc_default}${fgc_green}${fmt_bold}  bold${fmt_reset}${fgc_green}  normal${fmt_reset}  (green)\n"
    printf "3:  ${bgc_yellow}      ${bgc_default}${fgc_yellow}${fmt_bold}  bold${fmt_reset}${fgc_yellow}  normal${fmt_reset}  (yellow)\n"
    printf "4:  ${bgc_blue}      ${bgc_default}${fgc_blue}${fmt_bold}  bold${fmt_reset}${fgc_blue}  normal${fmt_reset}  (blue)\n"
    printf "5:  ${bgc_magenta}      ${bgc_default}${fgc_magenta}${fmt_bold}  bold${fmt_reset}${fgc_magenta}  normal${fmt_reset}  (magenta)\n"
    printf "6:  ${bgc_cyan}      ${bgc_default}${fgc_cyan}${fmt_bold}  bold${fmt_reset}${fgc_cyan}  normal${fmt_reset}  (cyan)\n"
    printf "7:  ${bgc_white}      ${bgc_default}${fgc_white}${fmt_bold}  bold${fmt_reset}${fgc_white}  normal${fmt_reset}  (white)\n"
}
