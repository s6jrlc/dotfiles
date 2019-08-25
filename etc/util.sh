#!/bin/sh

if [ -d $DOTPATH"/etc/util.d/" ]; then
	for f in $DOTPATH"/etc/util.d/*.sh"; then
		[ -r $f ] && sh $f
	done
	unset f
fi
