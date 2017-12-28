#!/bin/bash

REMOTE_CONNECT_HOST=$1;
LOCAL_KEY_PUB_FILE=$2;

if [ -z $REMOTE_CONNECT_HOST ]
then
   echo ":( Set REMOTE_CONNECT_HOST as first argument like: user@1.1.1.1"
   exit 1;
fi

if [ -z $LOCAL_KEY_PUB_FILE ]
then
   LOCAL_KEY_PUB_FILE='~/.ssh/id_rsa.pub';
fi

ssh "${REMOTE_CONNECT_HOST}" mkdir -p .ssh
cat "${LOCAL_KEY_PUB_FILE}" | ssh "${REMOTE_CONNECT_HOST}" 'cat >> .ssh/authorized_keys'
