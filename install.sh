#!/bin/sh

DOTPATH="~/.dotfiles/"
DOTREPO="https://github.com/s6jrlc/dotfiles/"

sh $DOTPATH"/etc/util.sh"

if has "git"; then
	git clone --recursive $DOTREPO $DOTPATH

elif has "curl" || has "wget"; then
	TAR="archive/master.tar.gz"

	if has "curl"; then
		curl -L $DOTREPO$TAR

	elif has "wget"; then
		wget -O - $DOTREPO$TAR

	fi | tar xzvf

	mv -f dotfiles-master $DOTPATH

else
	die "-$(sh_name): command not found: git, curl or wget required"
fi
sh $DOTPATH"/link.sh"

if is_bash; then
	cat <<- EOS >> ~/.bashrc
	export HISTCONTROL=ignoreboth
	EOS
elif is_zsh; then
	cat <<- EOS >> ~/.zshrc
	setopt histignorespace
	setopt histignorealldups
	EOS
fi
