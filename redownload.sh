#!/bin/bash

# get youtube ids
ls | grep -E '\-[a-zA-Z0-9_-]{11}\.mp3$' >youtubefiles.txt

mkdir redownload

while read p; do
    YTID="$(grep -Eo '\-[a-zA-Z0-9_-]{11}\.mp3$' <<<"$p" | sed 's/.\([^.]*\).*/\1/g')"
    echo "processing $p with id $YTID"
    mkdir redownload/"$p"
    cd redownload/"$p" || exit 1
    if ! youtube-dl -x -f bestaudio 'https://www.youtube.com/watch?v='"$YTID"; then
        echo "$p" >>../../fail.txt
    else
        echo "$YTID" >>../../success.txt
        echo "$p" >>../../successtitles.txt
    fi
    cd ../../ || exit 1
done <youtubefiles.txt
