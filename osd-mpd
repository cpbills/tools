#!/bin/bash

OSD=$HOME/bin/osd-text.sh
MPC=/usr/bin/mpc

MSG='Not Handled Yet'

case $1 in
    next)
        MSG='Next Track'
        STATUS=`$MPC next`
        ;;
    prev)
        MSG='Previous Track'
        STATUS=`$MPC prev`
        ;;
    toggle|pause|play)
        STATUS=`$MPC toggle`
        if [ $? -ne 0 ]; then
            MSG='[mpd] error playing song'
        else
            if echo "$STATUS" | grep -e '^\[playing\]' > /dev/null 2>&1; then
                MSG='welcome back'
            else
                MSG='pausing for now...'
            fi
        fi
        ;;
    *)
        STATUS=`mpc`
        if [ $? -ne 0 ]; then
            MSG='[mpd] error getting status'
        else
            if [ $(echo "$STATUS" | wc -l) -eq 1 ]; then
                MSG='the party is dead man, the music is stopped'
            else
                if echo "$STATUS" | grep -e '^\[playing\]' > /dev/null 2>&1; then
                    MSG='now playing'
                else
                    MSG='paused and waiting'
                fi
            fi
        fi
        ;;
esac
if [ $(echo "$STATUS" | wc -l) -eq 1 ]; then
    OUTPUT="$MSG"
else
    SONG=`echo "$STATUS"|head -n1`
    OUTPUT=`printf "%s\n%s\n" "$MSG" "$SONG"`
fi
$OSD -t "$OUTPUT"
