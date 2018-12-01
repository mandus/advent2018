#!/bin/bash
# Advent of Code 2018 - Åsmund Ødegård

#IFS=', ' read -r -a values <<< $*
IFS=$'\n' read -d '' -r -a values < $1

declare -i freq=0
for val in "${values[@]}" ; do
    curfreq=$freq
    freq=$((freq "$val"))
    echo "Current frquency ${curfreq}, change if ${val}; resulting frequency ${freq}"
done
