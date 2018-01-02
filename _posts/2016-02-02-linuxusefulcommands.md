---
layout: post
title: "Linux Useful Commands"
date: 2016-02-02 10:25:06
description: Linux Usefull Commands
tags: 
 - linux
---



**Network**

 - auto exit telnet
echo -e "^]\nclose"| telnet hostname 3306

 - tcpdump

 - tcp state
     netstat -an|awk '/^tcp/{++S[$NF]}END{for (a in S)print a,S[a]}'
 - nat
A(wan server):
iptables -t nat -A POSTROUTING -s source/24 -o em1 -j MASQUERADE
iptables -A FORWARD -s source/24 -o em1 -j ACCEPT
iptables -A FORWARD -d source/24 -m state --state ESTABLISHED,RELATED -i em1 -j ACCEPT
B(lan server):
route add default gw Aip em2

 - network limit(wondershaper and trickle)
wondershaper {interface} {down} {up}  -- limit network interface
the {down} and {up} are bandwidth in kilobits. So for example if you want to limit the bandwidth of interface eth1 to 256kbps uplink and 128kbps downlink,
wondershaper eth1 256 128
To clear the limit,
wondershaper clear eth1
trickle -u {up} -d {down} {program}   -- limit programe
Both {up} and {down} and bandwidth in KB/s. Now if you invoke it as,
trickle -u 8 -d 8 firefox  

 - test open port(without telnet)
 $ timeout 1 bash -c 'cat < /dev/null > /dev/tcp/ipaddress/80'
 $ echo $?

**Memory**

 - memory leak check
valgrind --leak-check=yes myprog arg1 arg2

**Disk**

 - create raid 10
mdadm --create /dev/md3 --run --level=10 --chunk=4 --raid-devices=4 /dev/sdf1 /dev/sdg1 /dev/sdh1 /dev/sdi1
   
**CPU**
  
**Software**

 - search rpm repo
 yum whatprovides *tshark*

