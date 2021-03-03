#!/bin/bash

USER=`echo $SETTINGS | jq -r .user.value`
PASSWORD=`echo $SETTINGS | jq -r .password.value`
PORT=`echo $SETTINGS | jq -r .port.value`

export USER
export PASSWORD
export PORT

$BIN_DIR/child-install.sh

/usr/sbin/sshd -D -p $PORT &