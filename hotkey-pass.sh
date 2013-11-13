#!/bin/sh

HEIGHT=5
WIDTH=30
COMMAND='~/tools/pass.sh'

/usr/bin/uxterm -g ${WIDTH}x${HEIGHT} -T 'password' -e $COMMAND
