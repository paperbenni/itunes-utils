#!/usr/bin/env bash

source utils.sh || exit 1
ituneslist Media*.xml > files.txt

while read i
do
	p="$(urldecode "$i")"
	if test -f "$p"
	then
		echo "copying $p"
		rsync -Pazvh "$p" /e/itunesmusic/
	else
		echo "skipping $p, not existing"
		continue
	fi
	echo "copying $p"
done < files.txt

echo "fertig"

