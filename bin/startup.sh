#!/bin/bash

USER=`echo $SETTINGS | jq -r .user`
PASSWORD=`echo $SETTINGS | jq -r .password`
PORT=`echo $SETTINGS | jq -r .port`

export USER
export PASSWORD
export PORT

$BIN_DIR/$APP_NAME-install.sh

/usr/sbin/sshd -D -p $PORT &