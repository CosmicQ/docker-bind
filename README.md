docker-bind
===========

ISC Bind server for general purpose internal name server with webmin for easy management.

[![](https://images.microbadger.com/badges/image/cosmicq/docker-bind.svg)](http://microbadger.com/images/cosmicq/docker-bind "Get your own image badge on microbadger.com")

[![](https://images.microbadger.com/badges/version/cosmicq/docker-bind.svg)](http://microbadger.com/images/cosmicq/docker-bind "Get your own version badge on microbadger.com")

### TL;DR ###

Make the persistent directories

    mkdir -p /srv/bind/etc
    mkdir /srv/bind/zones
    mkdir /srv/bind/webmin

Here is a sample command using all the options.

    docker run -d \
    -p 53:53 -p 53:53/udp \
    -p 10000:10000 \
    -v /srv/bind/etc:/etc/bind \
    -v /srv/bind/zones:/var/lib/bind \
    -v /srv/bind/webmin:/etc/webmin \
    -e PASS=newpass \
    -e NET=172.17.0.0\;192.168.0.0\;10.1.2.0 \
    --name bind --hostname bind \
    cosmicq/docker-bind

Log into webmin and manage your server

    http://hostname.or.ip:10000
    (root:newpass)

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

**/srv/bind/etc:/etc/bind** - Location of bind9 configuration files.

**/srv/bind/zones:/var/lib/bind** - Location of bind9 zone files.

**/srv/bind/webmin:/etc/webmin** - Location of webmin configuration files and plugins.

##### Environment Variables #####

**PASS** - This is used to set the root password which is primarily used for access webmin

**NET** - By default, webmin allows all IP addresses to access it.  By adding IP addresses
 you are restricting access to webmin.  You can add multiple IP addresses or ranges. 
 just separate them with a backslash semicolon. 

### Using Webmin ###

You should probably follow the guide at webmin.com

    http://doxfer.webmin.com/Webmin/BINDDNSServer

For a quick, just get me started guide, here is how to create a zone, add a host
and query the server for the record.

```
    Click on Servers -> BIND DNS Server
    Under "Existing DNS Zones", click on "Create master zone"
    Enter "Domain name / Network" (example: test.lab)
    Enter "Email address" (admin@test.lab)
    
    Save
    Click on "Edit Zone Options"
    In the "Allow queries from..." box enter "any"
    Save
    
    Click on "Address"
    Add your host (host.test.lab) Address (192.168.1.1)
    Create
    
    Click on System -> Running Proxesses
    Click the number for the named process
    Click on "kill".  The process will restart automatically
    
    Test with dig: dig @nameserver.or.ip host.test.lab
```

That should be enough to create your first zone.

When you are done with your updates, doing a simple stop/start to the container will get the 
service to re-read the files.

    docker stop bind
    docker start bind

### Editing the config files by hand ###

If you add or edit the config files in /srv/bind/named by hand, you need to restart the named
process for that change to take effect.  This uses phusion/baseimage which runs "runit" to
start services.  If the service dies, runit will start it again.  All we need to do to restart
a process is to kill it and it will start right back up again.

    Click on System -> Running processes
    Click on the process ID for /usr/sbin/named
    Click on the Kill button and the process will simply restart
