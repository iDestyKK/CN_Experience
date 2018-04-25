#!/bin/bash
#
# Clara's TMUX Theme (Bash Script)
# 
# Description:
#     A script that is used for multiple purposes. The main use is to populate
#     the status bar at the bottom that TMUX supplies. The script takes one
#     single argument, and that is the part of TMUX to render.
#
# Author:
#     Clara Nguyen (@iDestyKK)
#

# ----------------------------------------------------------------------------\
# 1. ARGUMENT CHECKING                                                   {{{1 |
#                                                                             |
#    Just to make sure that we are executing the application properly... and  |
#    not by doing something stupid. Otherwise we'd be printing garbage to     |
#    TMUX... not a good idea.                                                 |
# ----------------------------------------------------------------------------/

if [ $# -ne 1 ]; then
	printf "Usage: %s segment\n" "$0"
	exit 1
fi

# ----------------------------------------------------------------------------\
# 2. FUNCTIONS & GLOBALS                                                 {{{1 |
#                                                                             |
#    Just to make our lives easier. These are functions that will be used in  |
#    helping out with generating the TMUX content. These functions may (most  |
#    certainly will) use some globals, which are also defined here.           |
# ----------------------------------------------------------------------------/

# VARIABLES
# For arrow management
FIRST=0

# Previous & Current Colours
PREV_FG='colour0'
PREV_BG='colour0'
CUR_FG=$PREV_FG
CUR_BG=$PREV_BG

# Background of the TMUX statusbar (Default BG to resort to)
TMUX_BGC='colour233'

# Shell Exclusive Characters
SPLIT_CHAR_LEFT=''
SPLIT_CHAR_RIGHT=''

# SINOBUZ
DOTW_P=$(date +%u)
let "DOTW_P--"

# Characters for the days of the week
ELEM=(
	'月'
	'火'
	'水'
	'木'
	'金'
	'土'
	'日'
)

# Background colour for the elements
ELEM_BG=(
	'colour207'
	'colour196'
	'colour75'
	'colour28'
	'colour227'
	'colour204'
	'colour105'
)

# Background for the time elements near the day
ELEM_DBG=(
	'colour97'
	'colour88'
	'colour25'
	'colour22'
	'colour100'
	'colour132'
	'colour98'
)

# Foreground colour for the elements
ELEM_FG=(
	'colour15'
	'colour15'
	'colour15'
	'colour15'
	'colour236'
	'colour15'
	'colour15'
)

# The prompt
PROMPT=''

function set_fg() {
	# Synopsis   : set_fg num
	# Description: Set the foreground

	PREV_FG=$CUR_FG
	CUR_FG=$1
}

function set_bg() {
	# Synopsis   : set_bg num
	# Description: Set the background

	PREV_BG=$CUR_BG
	CUR_BG=$1
}

function set_colour() {
	# Synopsis   : set_colour fg bg
	# Description: Set the foreground and background

	set_fg $1
	set_bg $2
}

function init_prompt() {
	# Synopsis   : init_prompt
	# Description: Sets the prompt blank

	PROMPT=''
}

function append_prompt() {
	# Synopsis   : append_prompt str
	# Description: Adds to the end of the prompt

	PROMPT="${PROMPT}$1"
}

function append_current_colour() {
	# Synopsis   : append_current_colour
	# Description: Adds the current foreground and background to the end of the
	#              prompt

	append_prompt "#[fg=${CUR_FG},bg=${CUR_BG}]"
}

function append_left_arrow() {
	# Synopsis   : append_left_arrow
	# Description: Appends the SPLIT_CHAR_LEFT character with the background
	#              being the current colour's background, and the foreground
	#              being the previous background. Do this after doing your stuff
	#              in the module.
	
	if [ $FIRST -ne 0 ]; then
		append_prompt "#[fg=${PREV_BG},bg=${CUR_BG}]${SPLIT_CHAR_LEFT}"
	else
		FIRST=1
	fi
	append_current_colour
}

function append_right_arrow() {
	# Synopsis   : append_right_arrow
	# Description: Appends the SPLIT_CHAR_RIGHT character with the background
	#              being the previous colour's background, and the foreground
	#              being the current background. Do this before doing your
	#              stuff in the module.

	append_prompt "#[fg=${CUR_BG},bg=${PREV_BG}]${SPLIT_CHAR_RIGHT}"
	append_current_colour
}

# ----------------------------------------------------------------------------\
# 3. PROMPT FUNCTIONS                                                    {{{1 |
#                                                                             |
#    These are "Modules" that can be "appended" onto the TMUX prompt, whether |
#    it is on the left or the right. In the end, we can simply execute the    |
#    functions in the order that we want them to be displayed in. Simple? :)  |
# ----------------------------------------------------------------------------/

# Right Modules
function ip_address() {
	# Prints the current IP Address
	set_colour 'colour255' 'colour236'

	append_right_arrow
	append_prompt " IP: $(./scr/curip.sh) "
}

function battery() {
	# Prints out the current battery level
	set_colour 'colour255' 'colour198'

	append_right_arrow
	append_prompt " #[bold]$(./scr/battery.sh)% #[default]"
	append_current_colour
}

function cur_date() {
	# Prints out the date and time... in their own tabs
	#set_colour 'colour255' 'colour234'
	set_colour 'colour255' ${ELEM_DBG[$DOTW_P]}

	append_right_arrow
	append_prompt " #[bold]$(date +'%Y/%m/%d') #[default]"
	append_current_colour
}

function dotw() {
	# Prints a kanji of the day of the week.
	set_colour ${ELEM_FG[$DOTW_P]} ${ELEM_BG[$DOTW_P]}

	append_right_arrow
	append_prompt " #[bold]${ELEM[$DOTW_P]} #[default]"
	append_current_colour
}

function cur_time() {
	# Prints out the date and time... in their own tabs
	#set_colour 'colour255' 'colour234'
	set_colour 'colour255' ${ELEM_DBG[$DOTW_P]}

	append_right_arrow
	append_prompt " #[bold]$(date +'%H:%M') #[default]"
	append_current_colour
}

function p_hostname() {
	# Prints out the name of the machine.
	#set_colour 'colour15' 'colour234'
	set_colour ${ELEM_FG[$DOTW_P]} ${ELEM_BG[$DOTW_P]}
	
	append_left_arrow
	append_prompt "  #[bold]$(hostname)  #[default]"
	append_current_colour
}

# ----------------------------------------------------------------------------\
# 4. PRINT THE PROMPT                                                    {{{1 |
#                                                                             |
#    Here's where it all comes together. Construct the prompt... Now.         |
# ----------------------------------------------------------------------------/

# Start it out blank
init_prompt

# Now... we get specific.
if [ $1 == "left" ]; then
	# Left side of the Status Bar
	# Initial Condition
	set_colour 'colour255' $TMUX_BGC
	append_current_colour

	# The Modules
	p_hostname

	# There is an arrow at the end of the left prompt
	set_bg $TMUX_BGC
	append_left_arrow
elif [ $1 == "right" ]; then
	# Right side of the Status Bar
	# Initial Condition
	set_colour 'colour255' $TMUX_BGC
	append_current_colour

	# The Modules
	ip_address
	battery
	cur_date
	dotw
	cur_time
elif [ $1 == "bg" ]; then
	PROMPT=$TMUX_BGC
fi

# Print it out
echo "$PROMPT"
