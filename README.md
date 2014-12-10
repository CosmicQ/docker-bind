docker-bind
===========

ISC Bind server for general purpose internal name server with webmin for easy management.

### TL;DR ###

Here is a sample command using all the options.

    docker run -d \
    -p 53:53 -p 53:53/udp \
    -p 10000:10000 \
    -v /srv/bind/named:/etc/named \
    -v /srv/bind/webmin:/etc/webmin \
    -e PASS=newpass \
    -e NET=172.17.0.0\;192.168.0.0\;10.1.2.0 \
    --name bind --hostname bind \
    cosmicq/docker-bind

### Options ###

##### Ports #####

**53** - TCP functions for named.  You might not need this if you are not going to transfer
 zone files or anything.

**53/udp** - This is the bulk of the DNS lookups.

**10000** - This is for the webmin access so you can use a web interface to modify DNS.

##### Volumes #####

If you want any kind of persistence for DNS, that is if you want your information to survive
 reboots or anything, you might like to store it outside the container.  This also allows for
 easy backups and importing zone files.

I like to make all my external volumes on /srv/containername/volume so that is what is in the
 example.  You are free to change that to whatever makes you happy.

**/srv/bind/named:/etc/named** - Location of named zone files and configuration files.

**/srv/bind/webmin:/etc/webmin** - Location of webmin configuration files and plugins.

##### Environment Variables #####

**PASS** - This is used to set the root password which is primarily used for access webmin

**NET** - By default, webmin allows all IP addresses to access it.  By adding IP addresses
 you are restricting access to webmin.  You can add multiple IP addresses or ranges. 
 just separate them with a backslash semicolon. 

##### Extra #####

I like to add **--name** and **--hostname** options, but this is not necessary.

Notes for future documentation:
To hup named: docker exec -d bind sv hup named
