#!/usr/bin/env bash

function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

cat Media*.xml | grep -o 'file://.*' | sed 's/<\/string>$//g' | sed 's/file:\/\/localhost\/C:/\/c/g' | perl -MHTML::Entities -pe 'decode_entities($_);'> files.txt

while read i
do
	p="$(urldecode "$i")"
	if test -f "$p"
	then
		FILENAME="${p##*/}"
		SUM1="$(cksum "$p" | grep -o '^[0-9 ]*')"
		SUM2="$(cksum /e/itunesmusic/"$FILENAME" | grep -o '^[0-9 ]*')"
		echo "errore" > error.txt
		if ! [ "$SUM1" = "$SUM2" ]
		then
			echo "$SUM1 $SUM2"
			echo "files $p are different"
			rsync -azvP "$p" /e/itunesmusic/
			echo "files $p are different" >> error.txt
		else
			echo "file $p is identical"
		fi
	else
		echo "skipping $p"
		continue
	fi
done < files.txt
echo "fertig"

