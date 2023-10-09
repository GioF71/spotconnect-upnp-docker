#!/bin/bash

# errors
# 1 missing binary file

mkdir /app/release -p
mkdir /app/bin -p

ARCH=`uname -m`
echo "ARCH=[$ARCH]"

arch_amd64=x86_64
arch_arm_v7=armv7l
arch_arm_v8=aarch64

declare -A bin_file_name
bin_file_name[$arch_amd64]="spotupnp-linux-x86_64"
bin_file_name[$arch_arm_v7]="spotupnp-linux-arm"
bin_file_name[$arch_arm_v8]="spotupnp-linux-aarch64"

SELECT_BIN_FILE=${bin_file_name["${ARCH}"]}

if [ ! -f "/app/release/$SELECT_BIN_FILE" ]; then
    echo "File /app/release/$SELECT_BIN_FILE not found"
    exit 1
fi

if [ ! -f "/app/release/$SELECT_BIN_FILE-static" ]; then
    echo "File /app/release/$SELECT_BIN_FILE-static not found"
    exit 1
fi

echo "SELECT_BIN_FILE=[$SELECT_BIN_FILE]"

mkdir -p /app/bin

mv "/app/release/$SELECT_BIN_FILE" /app/bin/spotupnp-linux
chmod 755 /app/bin/spotupnp-linux

mv "/app/release/$SELECT_BIN_FILE-static" /app/bin/spotupnp-linux-static
chmod 755 /app/bin/spotupnp-linux-static

mkdir /app/conf -p
echo "$SPOT_CONNECT_VERSION" > /app/bin/version.txt

