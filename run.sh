#!/bin/bash

set -eux pipefail

function concat() {
    les=$1
    output=$2
    tmp="tmp.mp3"
    tmp2="tmp2.mp3"

    rm -f $output
    touch $output
    for track in {0..100}
    do
        curfile=`printf "les%02d_%02d.mp3" $les $track`

        if [ ! -f $curfile ]; then
            break
        fi

        ffmpeg -i $curfile -af "apad=pad_dur=2" $tmp
        ffmpeg -i "concat:${output}|${tmp}" -acodec copy ${tmp2}

        mv $tmp2 $output
        rm -f $tmp $tmp2
    done
}

for les in {1..100}
do
    filename=`printf "les%02d.mp3" $les`
    concat $les $filename
done
