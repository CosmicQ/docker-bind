#!/bin/bash

# We need to create basic config files if none exists.  This happens
# if an external volume is defined.

if [ ! -e /etc/named/named.conf ]; then
  cp /root/named/* /etc/named/ 
fi

if [ ! -e /etc/webmin/miniserv.conf ]; then
  cp -R /root/webmin/* /etc/webmin/ 
fi

# Honor the request to change the password

if [ ! -z $PASS ]; then
  echo root:$PASS | /usr/sbin/chpasswd
fi

# Add any networks to the allowed option

if [ ! -z $NET ]; then
  echo "allow=172.17.0.0 "$NET >> /etc/webmin/miniserv.conf
else
  echo "allow=172.17.0.0" >> /etc/webmin/miniserv.conf
fi

