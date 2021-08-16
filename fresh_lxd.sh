#!/bin/bash
# Assuming lxd is setup, a fresh container
# will be created under $img_name.

readonly img_name="wal-gdis-${1:-0}"
readonly script_name=${2:-"fresh_redis.sh"}
lxc launch images:debian/buster $img_name
lxc config set $img_name security.nesting true
lxc restart $img_name
lxc file push ./$script_name $img_name/
lxc exec $img_name -- "/$script_name"

