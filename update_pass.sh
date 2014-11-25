#!/bin/bash

# We need to create basic config files if none exists.  This happens
# if an external volume is defined.

if [ ! -e /etc/named/named.conf ]; then
  cp /root/named.tar.gz/* /etc/named/ 
fi

if [ ! -z $PASS ]; then
  echo root:$PASS | /usr/sbin/chpasswd
fi
