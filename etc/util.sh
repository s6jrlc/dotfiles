#!/bin/sh

if [ -d $DOTPATH"etc/util.d/" ]; then
	for f in $DOTPATH"etc/util.d/*.sh"; do
		[ -r $f ] && . $f
	done
	unset f
fi
