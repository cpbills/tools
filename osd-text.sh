#!/bin/bash

# bail early... why not...
if [ -z "$XAUTHORITY" ]; then
    echo "XAUTHORITY env variable not set: are you in X?"
    exit 1
fi

#FONT="xft:Nimbus Mono:size=20:minspace:rgba=rgb"
FONT='-adobe-courier-bold-r-normal--*-240-*-*-*-*-*-*'
COLOR="white"
DELAY=2
BAR=0
VAL=
MAX=
MSG=

OSD_OPTIONS="-d $DELAY -A center -p bottom -c $COLOR -O 2 -o 18"

while getopts "bv:m:t:" opt; do
    case $opt in
        b)
            BAR=1
            ;;
        v)
            VAL=$OPTARG
            ;;
        m)
            MAX=$OPTARG
            ;;
        t)
            MSG=$OPTARG
            ;;
    esac
done

# kill any stale instances
pkill -x osd_cat

if [ $BAR -eq 1 ]; then
    if [[ $VAL =~ ^[0-9]+$ ]] && [[ $MAX =~ ^[0-9]+$ ]]; then
        PERCENT=$(($VAL * 100 / $MAX))
        osd_cat -b slider -P $PERCENT -f $FONT $OSD_OPTIONS -T "$MSG" &
        exit
    else
        echo "you need to supply a value and max for the percent bar"
        exit 2
    fi
else
    # with no bar, it has to be read in from STDIN
    # i don't get it, either...
    lines=`echo "$MSG" | wc -l`
    echo "$MSG" | osd_cat -f $FONT $OSD_OPTIONS -l $lines &
    exit
fi
