#!/bin/bash
#
# CN_Experience Installer
#
# Description:
#     Bash script installer to set up the CN_Experience for users. It assumes
#     that you have zsh, tmux, and vim installed.
#
# Author:
#     Clara Nguyen (@iDestyKK)
#

printf \
	"%s\n%s\n\n%s\n\n" \
	"CN_Experience" \
	"Version 0.2.1 (Last Updated: 2019-01-31)" \
	"Installer Bash Script to make your life easier."

# -----------------------------------------------------------------------------
# Configure Script                                                         {{{1
# -----------------------------------------------------------------------------

# Paths
HOME_DIR=~
TARGET="${HOME_DIR}/.cn_experience"
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

# Colours
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
NORMAL=$(tput sgr 0)

function log_print {
	printf "%-56s" "$1"

	if [ $# -gt 1 ]; then
		printf "$2"
	fi
}

function log_status {
	if [ $1 -eq 0 ]; then
		# Success
		printf "[  ${GREEN}OK${NORMAL}  ]\n"
	else
		# Failure
		printf "[${RED}FAILED${NORMAL}]\n"
	fi
}

function append_line {
	if [ ! -e "$1" ]; then
		touch "$1"
	fi

	if ! cat "$1" | grep "$2" > /dev/null 2> /dev/null; then
		echo "$2" >> "$1"
	fi
}

# -----------------------------------------------------------------------------
# Copy over files                                                          {{{1
# -----------------------------------------------------------------------------

log_print "Checking..." "\n"

# Check if the directory exists already
log_print "  DIR: ~/.cn_experience... "
if [ ! -e "${TARGET}" ]; then
	printf "[ ${YELLOW}MAKE${NORMAL} ]\n"
	log_print "    Creating ~/.cn_experience..."

	MSG=$(mkdir "${TARGET}" 2>&1)
	RES=$?

	if [ $RES -eq 0 ]; then
		log_status 0
	else
		log_status 1
		log_print "    Failed to create \"${TARGET}\"." "\n"
		log_print "    ${MSG}" "\n"
		exit 1
	fi
else
	log_status 0
fi

# Check if .zshrc exists
log_print "  DIR: ~/.zshrc... "
if [ ! -e "${HOME_DIR}/.zshrc" ]; then
	printf "[ ${YELLOW}MAKE${NORMAL} ]\n"
	log_print "    Creating ~/.cn_experience..."

	MSG=$(touch "${HOME_DIR}/.zshrc" 2>&1)
	RES=$?

	if [ $RES -eq 0 ]; then
		log_status 0
	else
		log_status 1
		log_print "    Failed to create \"${HOME_DIR}/.zshrc\"." "\n"
		log_print "    ${MSG}" "\n"
		exit 1
	fi
else
	log_status 0
fi

# Check if .vim exists
log_print "  DIR: ~/.vim..."
if [ ! -e "${HOME_DIR}/.vim" ]; then
	printf "[ ${YELLOW}MAKE${NORMAL} ]\n"
	log_print "    Creating ~/.vim..."

	MSG=$(mkdir "${HOME_DIR}/.vim" 2>&1)
	RES=$?

	if [ $RES -eq 0 ]; then
		log_status 0
	else
		log_status 1
		log_print "    Failed to create \"${HOME_DIR}/.vim\"." "\n"
		log_print "    ${MSG}" "\n"
		exit 1
	fi
else
	log_status 0
fi

# Check if tar is a valid command
log_print "  CMD: tar"
if ! command -v tar > /dev/null; then
	log_status 1
	log_print "    tar is not installed." "\n"
	exit 1
else
	log_status 0
fi

printf "\n"

# Begin the copying
log_print "Copying files..." "\n"
shopt -s dotglob

# Configurations
log_print "  Default configurations..." "\n"

for F in "${SCRIPTPATH}/default/"*; do
	# log_print "    $(basename ${F})" "\n"
	cp -r "$F" "${TARGET}"
done

mkdir "${TARGET}/configs" 2> /dev/null > /dev/null

# ZSH Configs
log_print "    zsh..."
cp -r "${SCRIPTPATH}/configs/zsh" "${TARGET}/configs"
log_status 0

# VIM Configs
log_print "    vim..."
cp -r "${SCRIPTPATH}/configs/vim" "${TARGET}/configs"
log_status 0

# TMUX Configs
log_print "    tmux..."
cp -r "${SCRIPTPATH}/configs/tmux" "${TARGET}/configs"
log_status 0

# Youbi
log_print "  Youbi..."
cp -r "${SCRIPTPATH}/youbi" "${TARGET}"
log_status 0

# Scripts
log_print "  Scripts..."
cp -r "${SCRIPTPATH}/scr" "${TARGET}"
log_status 0

# Vim Plugins
log_print "  VIM Plugins (vim.tar.xz -> ~/.vim)..."

cd "${HOME_DIR}/.vim"

# I'm lazy. Extract from the tar
MSG=$(tar -xJf "${SCRIPTPATH}/pkg/vim.tar.xz" 2>&1)
RES=$?

if [ $RES -ne 0 ]; then
	log_status 1
	log_print "    Failed to extract \"${SCRIPTPATH}/pkg/vim.tar.xz\"." "\n"
	log_print "    ${MSG}" "\n"
	exit 1
else
	log_status 0
fi

# -----------------------------------------------------------------------------
# Inject data into existing files                                          {{{1
# -----------------------------------------------------------------------------

printf "\n"
log_print "Patching..." "\n"

# Assume ~/.zshrc exists. Append to .zshrc
log_print "  .zshrc..."
append_line "${HOME_DIR}/.zshrc" "source $HOME/.cn_experience/configs/zsh/.zsh.include"
log_status 0

# Append to .vimrc
log_print "  .vimrc..."
append_line "${HOME_DIR}/.vimrc" "source ~/.cn_experience/configs/vim/.vimrc"
log_status 0

# Append to .tmux.conf
log_print "  .tmux.conf..."
append_line "${HOME_DIR}/.tmux.conf" "source ~/.cn_experience/configs/tmux/.tmux.conf"
log_status 0
