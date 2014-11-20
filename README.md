docker-bind
===========

ISC Bind server for general purpose internal name server with webmin for easy management


    docker run -d -p 10000:10000 -v /srv/bind/named:/etc/named -v /srv/bind/webmin:/etc/webmin -e PASS=newpass cosmicq/docker-bind
