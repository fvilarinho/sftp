#!/bin/bash

source $BIN_DIR/functions.sh

echo "Gathering the service settings..."

SETTINGS=$(getCredentials)
USER=`echo $SETTINGS | jq -r .user`
PASSWORD=`echo $SETTINGS | jq -r .password`
PORT=`echo $SETTINGS | jq -r .port`

export USER
export PASSWORD
export PORT

echo "Service settings were gathered!"

$BIN_DIR/install.sh

echo "Starting the service..."

/usr/sbin/sshd -D -p $PORT