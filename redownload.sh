#!/bin/bash

# get youtube ids
ls | grep -E '\-[a-zA-Z0-9_-]{11}\.mp3$' >youtubefiles.txt

while read p; do
    YTID="$(grep -Eo '\-[a-zA-Z0-9_-]{11}\.mp3$' <<<"$p" | sed 's/.\([^.]*\).*/\1/g')"
    echo "processing $p with id $YTID"
done <youtubefiles.txt
