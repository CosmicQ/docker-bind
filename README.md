docker-bind
===========

ISC Bind server for general purpose internal name server with webmin for easy management

For the first run, you might want to scp the default config files out into an external
directory.

    docker run -d -p 10000:10000 -v /srv/bind/named:/etc/named -e PASS=newpass cosmicq/docker-bind
