
# Heading 2



# Local wifi router address

http://10.0.0.138/


# Speed tester:

https://fast.com/

Home NBN I get around 21 Mbps

Crazy but 4G at home is faster at 31-40 Mbps

# Restart!

sudo service networking restart

sudo service network-manager restart

OR if the network manager icon isn't in the top bar:

 killall nm-applet; nohup nm-applet &

# URL not working?

## First does it resolve?

 nslookup wiki.wgtn.cat-it.co.nz

## No, issue with local DNS?

 nslookup wiki.wgtn.cat-it.co.nz 127.0.0.1

If on the VPN, test wether DNS lookup directly against the DNS server fails:

 nslookup wiki.wgtn.cat-it.co.nz 192.168.15.1
 nslookup wiki.wgtn.cat-it.co.nz 192.168.124.1

Ip's of dns servers are in vpn settings UI.


## dnsmasq custom extra config

/etc/NetworkManager/dnsmasq.d/brendan.conf

Sometimes dnsmasq should be off on certain networks, like in Melbourne office lan:

$ sudo vim /etc/NetworkManager/NetworkManager.conf

[main]
plugins=ifupdown,keyfile
# dns=dnsmasq



## If you need to use google to help diagnose the issue temp use google's DNS:

This file is managed by Network manager but hack it temporarily:

vim /etc/resolv.conf

 nslookup 8.8.8.8

The real file that NM gives is using is:

/run/NetworkManager/resolv.conf



## Ok so DNS resolving isn't working locally

What is in resolve conf?

 cat /etc/resolv.conf

If empty something big is wrong.

TEMP can you ad some names servers to resolve.conf but these will get blown away later:

nameserver 8.8.8.8
nameserver 192.168.15.1
nameserver 192.168.124.1


# Are you connecting via ipv6? Try ipv4







# What is my MAC address for interface?

 sudo ip addr





