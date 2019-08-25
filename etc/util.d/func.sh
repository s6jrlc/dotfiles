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
