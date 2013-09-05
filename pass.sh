#!/bin/sh

SEED="someseed"
echo -n "site: "
read site
echo -n "pass: "
stty -echo
read pass
stty echo
echo
oldpass=`echo -n "$pass$site" | md5sum | cut -c1-8`
echo "old pass: $oldpass"
complexity_insurance='LoL69%'
pass=`echo -n "$pass$site" | mkpasswd -m sha-256 -s "$SEED" -s | cut -c34-44`
echo -n $pass$complexity_insurance | xclip
sleep 10
