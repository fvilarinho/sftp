#!/bin/bash

USER=`echo $SETTINGS | jq -r .user.value`
PASSWORD=`echo $SETTINGS | jq -r .password.value`

export USER
export PASSWORD

$BIN_DIR/child-install.sh

/usr/sbin/sshd -D -p $PORT &
rsync --daemon