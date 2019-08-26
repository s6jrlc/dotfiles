#!/bin/sh

. $DOTPATH"etc/util.sh"

cd $DOTPATH
if [ $? -ne 0 ]; then
	echo "-$(sh_name): $DOTPATH: No such file or directory" >&2
fi

for f in .??*; do
	[ $f = ".git" ] && continue
	[ $f = ".gitignore" ] && continue

	ln -snfv {$DOTPATH,$HOME}$f
done
