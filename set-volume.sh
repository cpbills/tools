#!/bin/bash

CHANNEL='Master Playback Volume'
TOGGLE='Master Playback Switch'
AMIXER=/usr/bin/amixer
OSD=/home/cpbills/bin/osd-text.sh
STEP=5
USE_OSD=1
VERBOSE=0
DO_MPD=1
OUTPUT=

STATUS=`$AMIXER cget name="$CHANNEL" | tail -n2`
OLD_VOLUME=`echo "$STATUS" | tail -n1 | cut -d, -f2`

case $1 in
    'mute')
        $AMIXER -q set Master toggle
        IS_IT_ON=`$AMIXER cget name="$TOGGLE" | tail -n1 | cut -d= -f2`
        if [ "$IS_IT_ON" = 'on' ]; then
            OUTPUT="ROCK OUT MAN!"
            if [ $DO_MPD -gt 0 ]; then
                mpc -q play
            fi
        else
            OUTPUT="Woah, woah woah... I need some quiet time."
            if [ $DO_MPD -gt 0 ]; then
                mpc -q pause
            fi
        fi
        ;;
    '+')
        $AMIXER -q set Master ${STEP}%+
        ;;
    '-')
        $AMIXER -q set Master ${STEP}%-
        ;;
    *)
        # remove anything from the end of the variable
        # that isn't a number e.g. '%'
        VOL=${1%[^0-9]*}
        $AMIXER -q set Master ${VOL}%
        ;;
esac

STATUS=`$AMIXER cget name="$CHANNEL" | tail -n2`
VOLUME=`echo "$STATUS" | tail -n1 | cut -d, -f2`

MIN=`echo "$STATUS" | head -n1 | cut -d, -f4 | tr -c -d '[0-9]'`
MAX=`echo "$STATUS" | head -n1 | cut -d, -f5 | tr -c -d '[0-9]'`

if [[ $OLD_VOLUME -eq $VOLUME ]] && [[ $1 != 'mute' ]]; then
    # prevent us from jamming the volume keys and clogging up the OSD/etc
    if [ $VERBOSE -gt 0 ]; then
        echo "no volume change, goodbye..."
    fi
    exit
fi

echo "$OLD_VOLUME $VOLUME $1"

PERCENT=`echo "(($VOLUME-$MIN)*100)/($MAX-$MIN)" | bc -l`
PERCENT=`printf "%02.0f\n" "$PERCENT"`

if [ $USE_OSD -gt 0 ]; then
    if [[ $1 == 'mute' ]]; then
        $OSD -t "$OUTPUT"
    else
        $OSD -t "Volume: ${PERCENT}%" -b -m $MAX -v $VOLUME
    fi
fi

if [ $VERBOSE -gt 0 ]; then
    echo $OUTPUT
fi
