#!/bin/bash

OSD=$HOME/bin/osd-text.sh
MPC=/usr/bin/mpc

MSG='Not Handled Yet'

case $1 in
    'next')
        MSG='Next Track'
        STATUS=`$MPC next`
        ;;
    'prev')
        MSG='Previous Track'
        STATUS=`$MPC prev`
        ;;
    *)
        exit
        ;;
esac
SONG=`echo "$STATUS"|head -n1`
OUTPUT=`printf "%s\n%s\n" "$MSG" "$SONG"`
$OSD -t "$OUTPUT"
