#!/bin/sh

# salt must be 8+ characters
salt='someseed'
# appended to passwords to make sure all character classes are covered
hit_all_reqs='LoL69%'
# password length
length=16
# length of sha-256 hash is 43 chars
hash_start=18
hash_end=$(((hash_start + length - 1) - ${#hit_all_reqs}))

read -p "site: " site
stty -echo
read -p "pass: " pass
stty echo
echo

pass_id=$(printf "%s%s" "$pass" "$site" | md5sum | cut -c1-8)
pass_hash=$(
  printf "%s%s" "$pass" "$site" \
  | mkpasswd -m sha-256 -S "$salt" -s \
  | cut -c$((5 + ${#salt}))- \
  | cut -c${hash_start}-${hash_end}
)
echo "pass id: $pass_id"
printf "%s%s" "$pass_hash" "$hit_all_reqs" | xclip
sleep 10
