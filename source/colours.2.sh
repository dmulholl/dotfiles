
# -------------------------------------------------------------------------
# Colour & Formatting Codes
# -------------------------------------------------------------------------

# Reset all attributes.
reset='\e[0m'

# Formatting.
bold='\e[1m'
dim='\e[2m'
underline='\e[4m'
blink='\e[5m'
hide='\e[8m'

# Foreground colour, default.
fgdefault='\e[39m'

# Foreground colours, normal.
black='\e[30m'
red='\e[31m'
green='\e[32m'
yellow='\e[33m'
blue='\e[34m'
magenta='\e[35m'
cyan='\e[36m'
white='\e[37m'

# Foreground colours, bright.
bblack='\e[90m'
bred='\e[91m'
bgreen='\e[92m'
byellow='\e[93m'
bblue='\e[94m'
bmagenta='\e[95m'
bcyan='\e[96m'
bwhite='\e[97m'

# Print a test set of colours.
function colours() {
    echo -e "${fgdefault}Normal:"
    echo -e "${fgdefault}- ${black}black"
    echo -e "${fgdefault}- ${red}red"
    echo -e "${fgdefault}- ${green}green"
    echo -e "${fgdefault}- ${yellow}yellow"
    echo -e "${fgdefault}- ${blue}blue"
    echo -e "${fgdefault}- ${magenta}magenta"
    echo -e "${fgdefault}- ${cyan}cyan"
    echo -e "${fgdefault}- ${white}white"
    echo -e
    echo -e "${fgdefault}Bright:"
    echo -e "${fgdefault}- ${bblack}bblack"
    echo -e "${fgdefault}- ${bred}bred"
    echo -e "${fgdefault}- ${bgreen}bgreen"
    echo -e "${fgdefault}- ${byellow}byellow"
    echo -e "${fgdefault}- ${bblue}bblue"
    echo -e "${fgdefault}- ${bmagenta}bmagenta"
    echo -e "${fgdefault}- ${bcyan}bcyan"
    echo -e "${fgdefault}- ${bwhite}bwhite"
}
