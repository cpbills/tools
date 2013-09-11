#!/bin/sh
# udev rule to set permissions so normal users can blink the light:
# KERNEL=="tpacpi::thinklight", RUN+="/bin/chmod 0666 /sys/devices/platform/thinkpad_acpi/leds/tpacpi::thinklight/brightness"

# Symlink to the ThinkLight brightness setting
THINKLIGHT='/sys/class/leds/tpacpi::thinklight/brightness'
CURRENT=`cat $THINKLIGHT`

action=$1

case $action in
  "blink")
    if [ $CURRENT -ne 0 ]; then
      echo 0 > "$THINKLIGHT"
    fi
    echo 255 > "$THINKLIGHT"
    sleep .1
    echo 0 > "$THINKLIGHT"
    ;;
  "off")
    echo 0 > "$THINKLIGHT"
    ;;
  "on")
    echo 255 > "$THINKLIGHT"
    ;;
  *)
    echo "Usage: $0 (blink|on|off)" >&2
    ;;
esac
