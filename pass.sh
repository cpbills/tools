#!/bin/sh

echo -n "site: "
read site
echo -n "pass: "
stty -echo
read pass
stty echo
echo -n "$pass$site" | md5sum | cut -c1-8
