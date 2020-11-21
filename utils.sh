#!/bin/bash

function urldecode() {
    : "${*//+/ }"
    echo -e "${_//%/\\x}"
}

ituneslist() {
    if [ -z "$1" ] || ! [ -e "$1" ]; then
        return 1
    fi
    cat "$1" | grep -o 'file://.*' | sed 's/<\/string>$//g' |
        sed 's/file:\/\/localhost\/C:/\/c/g' | perl -MHTML::Entities -pe 'decode_entities($_);'
}
