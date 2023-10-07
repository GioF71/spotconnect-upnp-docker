#!/bin/bash

binary_file=$(cat /app/bin/executable.txt)

CMD_LINE="/app/bin/$binary_file"

mkdir /app/conf -p

CMD_LINE="$CMD_LINE -x /config/config.xml -I -j -k -Z -r 320"
echo "Command Line: ["$CMD_LINE"]"
eval "$CMD_LINE"
