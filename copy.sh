#!/bin/bash

cd /e/itunesmusic

for i in ./*
do
	filename="${i##*/}"
	if [ -e /f/"$filename" ]
	then
		echo "$filename already exists"
	else
		echo "coying $i"
		rsync -Pazvh "$i" /f/
	fi
done
