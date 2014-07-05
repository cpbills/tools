#!/bin/sh

HEIGHT=50
WIDTH=80
COMMAND='/usr/bin/mutt -F ~/.mutt/local.conf'

/home/cpbills/tools/grab-mail.sh &
/usr/bin/uxterm -g ${WIDTH}x${HEIGHT} -T 'mutt' -e $COMMAND
