#
# Dotfile Installer
# 
# Description:
#     Copies Clara Nguyen's dotfiles and other configurations into the home
#     directory. This WILL overwrite files, so be careful.
#
# Author:
#     Clara Nguyen
#

# Simply copy everything.
cp -r \
	scr        \
	youbi      \
	.vim       \
	.tmux.conf \
	.vimrc     \
	.zsh.*     \
	~/
