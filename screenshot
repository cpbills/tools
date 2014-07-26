#!/bin/sh

TIME=`/bin/date +"%F_%T"`
DIR="$HOME/files/images/screenshots/"
SCROT="/usr/bin/scrot ${DIR}/${TIME}.png"

if [ ! -d "$DIR" ]; then
    mkdir -p "$DIR" || die "Could not create directory: $!"
fi

# Sleep is necessary to allow scrot to have kb/mouse control
sleep 0.5

if [ "$1" = "root" ]; then
  $SCROT
else
  $SCROT -bs
fi
