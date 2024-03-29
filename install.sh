#!/bin/sh

DOTPATH=$HOME"/.dotfiles"
DOTREPO="https://github.com/s6jrlc/dotfiles/"

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
	[ ${SHELL##*/} = "bash" ]
}
is_zsh() {
	[ ${SHELL##*/} = "zsh" ]
}
sh_name() {
	echo ${SHELL##*/}
}

pfm_name() {
	PLATFORM=""
	case $(uname | lower) in
		*'linux'*)	PLATFORM='linux'	;;
		*'darwin'*)	PLATFORM='macos'	;;
		*'m'*'_nt'*) PLATFORM='msys2'	;;
		*)	PLATFORM='unknown'	;;
	esac
	echo $PLATFORM
}

is_linux() {
	[ $(pfm_name) = "linux" ]
}
is_macos() {
	[ $(pfm_name) = "macos" ]
}
alias is_osx=is_macos
alias is_macosx=is_macos

file_header() {
#	export_cargo_home=
#	if [ $(pfm_name) = "msys2" ]; then
#		export_cargo_home="export CARGO_HOME=~/.cargo"
#	fi
	cat <<- EOS
	#
	# $1
	#
	
	EOS
}

if [ -d $DOTPATH ]; then
	echo $DOTPATH": already exists"

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

cd $DOTPATH
if [ $? -ne 0 ]; then
	echo "-$(sh_name): $DOTPATH: No such file or directory" >&2
	exit 1
fi

if [ $(pfm_name) = "msys2" ]; then
	echo '!!!!! caution !!!!!'
	echo 'Msys2 / MinGW x86 / MinGW x64 need some following operations to create SymLinks'
	echo ' - Run the shell as Administrator'
	echo ' - Uncomment "MSYS=winsymlinks:nativestrict" in INI file dependent on PFM'
	read -p 'Press any key to continue this script: '
fi

for f in .??*; do
	[ $f = ".git" ] && continue
	[ $f = ".gitignore" ] && continue

	ln -snfv {$DOTPATH,$HOME}"/"$f
done

IFS_BACKUP=$IFS
IFS=$'\n'
if is_bash; then
	shrc=~/.bashrc
	profile=~/.bash_profile
	if [ ! -f $shrc ]; then
		file_header $shrc >> $shrc
	fi
	if [ ! -f $profile -a ! is_macos ]; then
		file_header $profile >> $profile
		echo "[[ -f $shrc ]] && . $shrc" >> $profile
	fi
	lines=(\
		"export HISTCONTROL=ignoreboth"\
	)
	for line in ${lines[@]}; do
		if [ -z $(grep "^$line" "$shrc") ]; then
			echo "add '"$line"' to "$shrc
			echo $line >> $shrc
		fi
	done
elif is_zsh; then
	shrc=~/.zshrc
	profile=~/.zprofile
	if [ ! -f $shrc ]; then
		file_header $shrc >> $shrc
	fi
	if [ ! -f $profile -a ! is_macos ]; then
		file_header $profile >> $profile
		echo "[[ -f $shrc ]] && . $shrc" >> $profile
	fi
	inserted_lines=(\
		'setopt histignorespace'\
		'setopt histignorealldups'\
	)
#	commented_line_regexs=(
#		'bindkey \\"\^H\\" backward-kill-word'
#	)
	for line in ${inserted_lines[@]}; do
		if [ -z $(grep "^$line" "$shrc") ]; then
			echo "add '"$line"' to "$shrc
			echo $line >> $shrc
		fi
	done
#	for line in ${commented_line_regexs[@]}; do
#		echo "comment out '$line'"
#		sed -i -e "/$line/ s/^#*/#/" $shrc
#	done
else
	echo "-$(sh_name): Not compatible installation script yet" >&2
fi
IFS=$IFS_BACKUP
