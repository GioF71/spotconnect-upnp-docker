#!/bin/bash

# errors
# 1 invalid parameter

DEFAULT_UID=1000
DEFAULT_GID=1000

if [ -z "${PUID}" ]; then
  PUID=$DEFAULT_UID;
  echo "Setting default value for PUID: ["$PUID"]"
fi

if [ -z "${PGID}" ]; then
  PGID=$DEFAULT_GID;
  echo "Setting default value for PGID: ["$PGID"]"
fi

DEFAULT_USER_NAME=spotc
DEFAULT_GROUP_NAME=spotc
DEFAULT_HOME_DIR=/home/$DEFAULT_USER_NAME

USER_NAME=$DEFAULT_USER_NAME
GROUP_NAME=$DEFAULT_GROUP_NAME
HOME_DIR=$DEFAULT_HOME_DIR

echo "Ensuring user with uid:[$PUID] gid:[$PGID] exists ...";
### create group if it does not exist
if [ ! $(getent group $PGID) ]; then
    echo "Group with gid [$PGID] does not exist, creating..."
    groupadd -g $PGID $GROUP_NAME
    echo "Group [$GROUP_NAME] with gid [$PGID] created."
else
    GROUP_NAME=$(getent group $PGID | cut -d: -f1)
    echo "Group with gid [$PGID] name [$GROUP_NAME] already exists."
fi
### create user if it does not exist
if [ ! $(getent passwd $PUID) ]; then
    echo "User with uid [$PUID] does not exist, creating..."
    useradd -g $PGID -u $PUID -M $USER_NAME
    echo "User [$USER_NAME] with uid [$PUID] created."
else
    USER_NAME=$(getent passwd $PUID | cut -d: -f1)
    echo "user with uid [$PUID] name [$USER_NAME] already exists."
    HOME_DIR="/home/$USER_NAME"
fi
### create home directory
if [ ! -d "$HOME_DIR" ]; then
    echo "Home directory [$HOME_DIR] not found, creating."
    mkdir -p $HOME_DIR
    echo ". done."
fi
chown -R $PUID:$PGID $HOME_DIR
chown -R $PUID:$PGID /config

executable_txt_file_name="/app/bin/executable.txt"
if [[ -n "$PREFER_STATIC" ]]; then
    echo "PREFER_STATIC=[$PREFER_STATIC]"
    if [[ "${PREFER_STATIC^^}" == "YES" || "${PREFER_STATIC^^}" == "Y" ]]; then
        echo "Selecting static version ..."
        executable_txt_file_name="/app/bin/executable-static.txt"
        echo ". done."
    elif [[ "${PREFER_STATIC^^}" != "NO" && "${PREFER_STATIC^^}" != "N" ]]; then
        echo "Invalid value for PREFER_STATIC [$PREFER_STATIC]!"
        exit 1
    fi
fi

binary_file=$(cat $executable_txt_file_name)
version=$(cat /app/bin/version.txt)

echo "Using SpotConnect upnp version [${version}]"

CMD_LINE="/app/bin/$binary_file"

mkdir /app/conf -p

CMD_LINE="$CMD_LINE -x /config/config.xml -I -j -k -Z -r 320"
echo "Command Line: ["$CMD_LINE"]"
su - $USER_NAME -c "$CMD_LINE"
