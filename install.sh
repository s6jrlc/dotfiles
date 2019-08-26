#!/bin/sh

exist() {
	which $1 > /dev/null 2>&1
	return $?
}

has() {
	exist $@
}

lower() {
	if [ $# -eq 0 ]; then
		cat <&0
	elif [ $# -eq 1 ]; then
		if [ -f $1 -a -r $1 ]; then
			cat $1
		else
			echo $1
		fi
	else
		return 1
	fi | tr "[:upper:]" "[:lower:]"
}

is_bash() {
	[ -n $BASH_VERSION ]
}
is_zsh() {
	[ -n $ZSH_VERSION ]
}
sh_name() {
	SH="sh"
	if is_bash; then
		SH="bash"
	elif is_zsh; then
		SH="zsh"
	fi

	echo $SH
}

os_name() {
	PLATFORM=""
	case $(uname | lower) in
		*'linux'*)	PLATFORM='linux'	;;
		*'darwin'*)	PLATFORM='macos'	;;
		*)	PLATFORM='unknown'	;;
	esac
	echo $PLATFORM
}

is_linux() {
	[ $(os_name) = "linux" ]
}
is_macos() {
	[ $(os_name) = "macos" ]
}
alias is_osx=is_macos
alias is_macosx=is_macos

DOTPATH="~/.dotfiles/"
DOTREPO="https://github.com/s6jrlc/dotfiles/"

if [ -d $DOTPATH ]; then
	echo "$DOTPATH: already exists"
else
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
		echo "-$(sh_name): command not found: git, curl or wget required" >&2
	fi
fi

#. $DOTPATH"etc/util.sh"

#. $DOTPATH"link.sh"

cd $DOTPATH
if [ $? -ne 0 ]; then
	echo "-$(sh_name): $DOTPATH: No such file or directory" >&2
	exit 1
fi

for f in .??*; do
	[ $f = ".git" ] && continue
	[ $f = ".gitignore" ] && continue

	ln -snfv {$DOTPATH,"~/"}$f
done

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
