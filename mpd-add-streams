#!/bin/sh

STREAM_LIST="/home/cpbills/.config/streaming_radio"
sed -e 's/\s*#.*$//g' $STREAM_LIST | while read stream; do
    if [ "${stream}x" != "x" ]; then
        mpc add $stream
    fi
done
