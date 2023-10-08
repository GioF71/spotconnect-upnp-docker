#!/bin/bash

apt-get update
apt-get install -y wget unzip

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

SPOT_CONNECT_VERSION="0.2.6"

cd /app/release
wget "https://github.com/philippe44/SpotConnect/releases/download/${SPOT_CONNECT_VERSION}/SpotConnect-${SPOT_CONNECT_VERSION}.zip"
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
echo "$SPOT_CONNECT_VERSION" > /app/bin/version.txt

apt-get remove -y wget unzip
apt-get autoremove -y

rm -Rf /app/release/
rm -rf /var/lib/apt/lists/*
