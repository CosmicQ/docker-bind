#!/bin/bash

# We need to create basic config files if none exists.  This happens
# if an external volume is defined.

if [ ! -e /etc/bind/named.conf ]; then
  cp /root/named/* /etc/bind/ 
fi

# The bind directory need to be owned by the bind user
chown bind: /etc/bind/*
chown bind: /etc/bind/
chown bind: /var/lib/bind/*
chown bind: /var/lib/bind/

if [ ! -e /etc/webmin/miniserv.conf ]; then
  cp -R /root/webmin/* /etc/webmin/ 
fi

# Honor the request to change the password

if [ ! -z $PASS ]; then
  echo root:$PASS | /usr/sbin/chpasswd
fi

# Add any networks to the allowed option

if [ ! -z $NET ]; then
  MYNET=${NET//;/\ }
  cat /root/webmin/miniserv.conf > /etc/webmin/miniserv.conf
  echo 'allow='$MYNET >> /etc/webmin/miniserv.conf
fi
