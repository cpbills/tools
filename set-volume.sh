#!/bin/bash

CHANNEL='Master Playback Volume'
TOGGLE='Master Playback Switch'
AMIXER=/usr/bin/amixer

NEW_VAL=$1

if [ -n "$NEW_VAL" ]; then
    if [ "$NEW_VAL" = 'mute' ]; then
        $AMIXER -q set Master toggle
        IS_IT_ON=`$AMIXER cget name="$TOGGLE" | tail -n1 | cut -d= -f2`
        if [ "$IS_IT_ON" = 'on' ]; then
            echo "UNMUTED"
        else
            echo "MUTED"
        fi
        exit
    else
        $AMIXER -q set Master $NEW_VAL
    fi
fi

STATUS=`$AMIXER cget name="$CHANNEL" | tail -n2`
MIN=`echo "$STATUS" | head -n1 | cut -d, -f4 | tr -c -d '[0-9]'`
MAX=`echo "$STATUS" | head -n1 | cut -d, -f5 | tr -c -d '[0-9]'`
VOLUME=`echo "$STATUS" | tail -n1 | cut -d, -f2`
echo "$MIN $MAX $VOLUME"
