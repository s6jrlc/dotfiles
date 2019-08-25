#!/bin/sh

sh $DOTPATH"/etc/util.sh"

cd $DOTPATH
if [ $? -ne 0 ]; then
	die "-$(sh_name): $DOTPATH: No such file or directory"
fi

for f in .??*; do
	[ $f = ".git" ] && continue

	ln -snfv {$DOTPATH,$HOME}$f
done
