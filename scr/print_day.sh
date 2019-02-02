#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

DAY=$(date +%u)
if [[ $# -eq 1 ]]; then
	DAY=$1
fi
DIR="${SCRIPTPATH}/../youbi"
FILEARR=(
	''
	'monday.txt'
	'tuesday.txt'
	'wednesday.txt'
	'thursday.txt'
	'friday.txt'
	'saturday.txt'
	'sunday.txt'
)

NOCOLOUR=$(tput sgr0)
COLOURS=(
	$(tput sgr0)
	$(tput setaf 213)
	$(tput setaf 196)
	$(tput setaf 14)
	$(tput setaf 10)
	$(tput setaf 11)
	$(tput setaf 211)
	$(tput setaf 105)
)

printf "${COLOURS[$DAY]}"
cat "${DIR}/${FILEARR[$DAY]}"
printf "$NOCOLOUR"
