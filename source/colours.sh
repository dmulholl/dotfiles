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
dot_colours() {
    printf "\e[0m0:  \e[40m      \e[0m\e[30m\e[1m  bold\e[0m\e[30m  normal\e[0m  (black)\n"
    printf "\e[0m1:  \e[41m      \e[0m\e[31m\e[1m  bold\e[0m\e[31m  normal\e[0m  (red)\n"
    printf "\e[0m2:  \e[42m      \e[0m\e[32m\e[1m  bold\e[0m\e[32m  normal\e[0m  (green)\n"
    printf "\e[0m3:  \e[43m      \e[0m\e[33m\e[1m  bold\e[0m\e[33m  normal\e[0m  (yellow)\n"
    printf "\e[0m4:  \e[44m      \e[0m\e[34m\e[1m  bold\e[0m\e[34m  normal\e[0m  (blue)\n"
    printf "\e[0m5:  \e[45m      \e[0m\e[35m\e[1m  bold\e[0m\e[35m  normal\e[0m  (magenta)\n"
    printf "\e[0m6:  \e[46m      \e[0m\e[36m\e[1m  bold\e[0m\e[36m  normal\e[0m  (cyan)\n"
    printf "\e[0m7:  \e[47m      \e[0m\e[37m\e[1m  bold\e[0m\e[37m  normal\e[0m  (white)\n"
}
