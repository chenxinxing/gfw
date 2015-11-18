#/etc/config/shadowsocks.json
#{
#    "server":"173.252.192.241",
#    "server_port":8089,
#    "local_address": "127.0.0.1",
#    "local_port":1080,
#    "password":"hell0love",
#    "timeout":300,
#    "method":"aes-256-cfb"
#}
#
#

#!/bin/sh
#iptalbes -t nat --list
#iptables -t nat -vnL --line-number
#iptables -t nat -D POSTROUTING 1  //删除nat表中postrouting的第一条规则
#iptables -t nat -D PREROUTING 1  //删除nat表中postrouting的第一条规则
#iptables -t nat -D SHADOWSOCKS 25  //删除nat表中postrouting的第一条规则


#create a new chain named SHADOWSOCKS
iptables -t nat -N SHADOWSOCKS
#iptables -t nat -A SHADOWSOCKS -j LOG --log-level 7 --log-prefix "SHADOWSOCKS REDIRECT:"

2014-09-22 16:04:08	Looking up host "107.167.177.172"


    "server":"54.187.245.102",
    "server":"107.167.177.172",


iptables -t nat -A SHADOWSOCKS -d 107.167.177.172 -j RETURN -m comment --comment "pass through google VPS ss"


ipset -! -N setmefree iphash
ipset -! -N googleplay iphash
iptables -t nat -A SHADOWSOCKS -p udp -m set --match-set setmefree dst  --dport 443 -j REDIRECT --to-port 1080
iptables -t nat -A SHADOWSOCKS -p tcp -m set --match-set setmefree dst  --dport 80 -j REDIRECT --to-port 1080
iptables -t nat -A SHADOWSOCKS -p udp -m set --match-set setmefree dst  --dport 80 -j REDIRECT --to-port 8087
iptables -t nat -A SHADOWSOCKS -p tcp -m set --match-set setmefree dst  --dport 5228 -j REDIRECT --to-port 1080 -m comment --comment "google play 下载端口TCP"
iptables -t nat -A SHADOWSOCKS -p udp -m set --match-set setmefree dst  --dport 5228 -j REDIRECT --to-port 1080 -m comment --comment "google play 下载端口UDP"

iptables -t nat -A SHADOWSOCKS -p tcp -m set --match-set googleplay dst --dport 80 -j REDIRECT --to-port 1080
iptables -t nat -A SHADOWSOCKS -p tcp -d 74.125.235.0/24 --dport 80 -j REDIRECT --to-ports 1080 -m comment --comment "google play:android.clients.google.com"


# Ignore your shadowsocks server's addresses
# It's very IMPORTANT, just be careful.
iptables -t nat -A SHADOWSOCKS -d 173.252.192.241 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 54.164.77.52 -j RETURN

#bypass DNS servers
iptables -A SHADOWSOCKS -t nat -p tcp -d 8.8.8.8 -j RETURN
iptables -A SHADOWSOCKS -t nat -p tcp -d 8.8.4.4 -j RETURN
iptables -A SHADOWSOCKS -t nat -p tcp -d 168.95.1.1 -j RETURN
iptables -A SHADOWSOCKS -t nat -p udp -d 168.95.1.1 -j RETURN
iptables -A SHADOWSOCKS -t nat -p tcp -d 168.95.192.1 -j RETURN
iptables -A SHADOWSOCKS -t nat -p udp -d 168.95.192.1 -j RETURN
iptables -A SHADOWSOCKS -t nat -p tcp -d 114.114.114.114 -j RETURN
iptables -A SHADOWSOCKS -t nat -p udp -d 114.114.114.114 -j RETURN
iptables -A SHADOWSOCKS -t nat -p tcp -d 114.114.115.115 -j RETURN
iptables -A SHADOWSOCKS -t nat -p udp -d 114.114.115.115 -j RETURN
iptables -A SHADOWSOCKS -t nat -p tcp -d 10.3.48.133 -j RETURN
iptables -A SHADOWSOCKS -t nat -p tcp -d 10.3.48.134 -j RETURN
iptables -A SHADOWSOCKS -t nat -p tcp -d 208.67.222.222 -j RETURN
iptables -A SHADOWSOCKS -t nat -p udp -d 208.67.222.222 -j RETURN
iptables -A SHADOWSOCKS -t nat -p tcp -d 208.67.220.220 -j RETURN
iptables -A SHADOWSOCKS -t nat -p udp -d 208.67.220.220 -j RETURN

iptables -A SHADOWSOCKS -t nat -p tcp -d 223.5.5.5 -j RETURN
iptables -A SHADOWSOCKS -t nat -p udp -d 223.5.5.5 -j RETURN
iptables -A SHADOWSOCKS -t nat -p tcp -d 223.6.6.6 -j RETURN
iptables -A SHADOWSOCKS -t nat -p udp -d 223.6.6.6 -j RETURN

#
#iptables -A OUTPUT -p udp -m multiport --sport 53,1053,2053 -j ACCEPT  -m comment --comment "ripe.net"   //从本地53端口出站的数据包出站通过
#iptables -A OUTPUT -p udp -m udp --dport 53 -j ACCEPT  -m comment --comment "ripe.net" //去往远程DNS服务器53端口的数据包出站通过

# Ignore LANs IP address
iptables -t nat -A SHADOWSOCKS -d 0.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 10.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 127.0.0.0/8 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 169.254.0.0/16 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 172.16.0.0/12 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 192.168.0.0/16 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 224.0.0.0/4 -j RETURN
iptables -t nat -A SHADOWSOCKS -d 240.0.0.0/4 -j RETURN

#Ignore if the destination is  China IP
#iptables -A prerouting_rule -t nat -m geoip -p tcp --destination-country CN -j RETURN


#bypass iOS notification, PPTP and other connections
iptables -A SHADOWSOCKS -t nat -p tcp -d 17.0.0.0/8 --dport 5223 -j RETURN -m comment --comment "#iOS notification"

#Redirect what you want

#Google
#iptables -t nat -A SHADOWSOCKS -p tcp -d 74.125.0.0/16 -j REDIRECT --to-ports 1080
iptables -t nat -A SHADOWSOCKS -p tcp -d 173.194.0.0/16 --dport 443 -j REDIRECT --to-ports 1080
iptables -t nat -A SHADOWSOCKS -p tcp -d 74.125.130.101/16 --dport 443 -j REDIRECT --to-ports 1080
iptables -t nat -A PREROUTING -p tcp -d 173.194.0.0/16 --dport 80 -j REDIRECT --to-ports 8087
iptables -t nat -A PREROUTING -p tcp -d 74.125.130.101/16 --dport 80 -j REDIRECT --to-ports 8087

iptables -t nat -A PREROUTING -p tcp -d 74.125.235.0/24 --dport 80 -j REDIRECT --to-ports 1080

##Youtube
#iptables -t nat -A SHADOWSOCKS -p tcp -d 208.117.224.0/19 -j REDIRECT --to-ports 1080
#iptables -t nat -A SHADOWSOCKS -p tcp -d 209.85.128.0/17 -j REDIRECT --to-ports 1080
iptables -t nat -A PREROUTING -p tcp -d 173.194.72.0/24 -j REDIRECT --to-ports 8087
iptables -t nat -A PREROUTING -p tcp -d 173.194.72.0/24 --dport 80 -j REDIRECT --to-ports 8087
iptables -t nat -A SHADOWSOCKS -p tcp -d 173.194.72.0/24 --dport 443 -j REDIRECT --to-ports 1080

#Twitter
#iptables -t nat -A SHADOWSOCKS -p tcp -d 199.59.148.0/22 -j REDIRECT --to-ports 1080
iptables -t nat -A SHADOWSOCKS -p tcp -d 199.59.148.0/22 --dport 443 -j REDIRECT --to-ports 1080
iptables -t nat -A PREROUTING -p tcp -d 199.59.148.0/22 --dport 80 -j REDIRECT --to-ports 8087

#dropbox
iptables -t nat -A SHADOWSOCKS -p tcp -d  108.160.0.0/16 --dport 443 -j REDIRECT --to-ports 1080
iptables -t nat -A PREROUTING -p tcp -d 108.160.0.0/16 --dport 80 -j REDIRECT --to-ports 8087

#Shadowsocks.org
#iptables -t nat -A SHADOWSOCKS -p tcp -d 199.27.76.133/32 -j REDIRECT --to-ports 1080

#1024 t66y.com aisex.com
iptables -t nat -A PREROUTING -p tcp -d 208.94.244.99/32 --dport 80 -j REDIRECT --to-ports 8087
iptables -t nat -A PREROUTING -p tcp -d 184.154.128.246/32 --dport 80 -j REDIRECT --to-ports 8087



#通过 APNIC 查询到 173.252.64.0/24 均属于 facebook  31.13.79.81  31.13.79.0 - 31.13.79.255
iptables -t nat -A SHADOWSOCKS -p tcp -d 173.252.0.0/16 --dport 443 -j REDIRECT --to-ports 1080
iptables -t nat -A PREROUTING -p tcp -d 173.252.0.0/16 --dport 80 -j REDIRECT --to-ports 8087
iptables -t nat -A SHADOWSOCKS -p tcp -d 31.13.0.0/16 --dport 443 -j REDIRECT --to-ports 1080
iptables -t nat -A PREROUTING -p tcp -d 31.13.0.0/16 --dport 80 -j REDIRECT --to-ports 8087

#Anything else should be ignore
iptables -t nat -A SHADOWSOCKS -p tcp -j RETURN

# Apply the rules
iptables -t nat -A PREROUTING -p tcp -j SHADOWSOCKS