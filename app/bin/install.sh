#!/bin/bash

mkdir /app/release -p

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

echo "SELECT_BIN_FILE=[$SELECT_BIN_FILE]"

cd /app/release
wget https://github.com/philippe44/SpotConnect/releases/download/0.2.6/SpotConnect-0.2.6.zip
unzip SpotConnect*zip
rm SpotConnect*zip

mkdir -p /app/bin

mv $SELECT_BIN_FILE /app/bin/
chmod 755 "/app/bin/$SELECT_BIN_FILE"

mv "$SELECT_BIN_FILE-static" /app/bin/
chmod 755 "/app/bin/$SELECT_BIN_FILE-static"

mkdir /app/conf -p
echo "$SELECT_BIN_FILE" > /app/bin/executable.txt
echo "$SELECT_BIN_FILE-static" > /app/bin/executable-static.txt

rm -Rf /app/release/
rm -rf /var/lib/apt/lists/*
