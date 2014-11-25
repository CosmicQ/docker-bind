docker-bind
===========

ISC Bind server for general purpose internal name server with webmin for easy management

For the TL;DR here is the full command with all the options

    docker run -d \
    -p 53:53 -p 53:53/udp \
    -p 10000:10000 \
    -v /srv/bind/named:/etc/named \
    -v /srv/bind/webmin:/etc/webmin \
    -e PASS=newpass \
    -e NET="192.168.0.0 10.1.2.0"\
    cosmicq/docker-bind


