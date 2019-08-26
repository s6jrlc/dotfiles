#!/bin/sh

if [ -d $DOTPATH"etc/util.d/" ]; then
	for f in $DOTPATH"etc/util.d/*.sh"; do
		[ -r $f ] && sh $f
	done
	unset f
fi
