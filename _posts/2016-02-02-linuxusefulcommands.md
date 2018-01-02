---
layout: post
title: "Linux Useful Commands"
date: 2016-02-02 10:25:06
description: Linux Usefull Commands
tags: 
 - linux
---

**Overview**

![img]({{ '/assets/images/Linux-Diagnosis.png' | relative_url }}){: .center-image }*(°0°)*



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

 - mtr(ping and traceroute)
mtr ip_address or dns

**Memory**

 - memory leak check
valgrind --leak-check=yes myprog arg1 arg2
 - memory stats
cat /proc/meminfo
vmstat -s

**Disk**

 - create raid 10
mdadm --create /dev/md3 --run --level=10 --chunk=4 --raid-devices=4 /dev/sdf1 /dev/sdg1 /dev/sdh1 /dev/sdi1
   
**CPU**

 - command command
top or cat /proc/cpuinfo

**Software**

 - search rpm repo
 yum whatprovides *tshark*

**Process**

 - process diagnosis:
strace -c -p pid
**File**  

 - list open files
lsof:COMMAND PID USER FD TYPE DEVICE SIZE/OFF NODE NAME
FD – Represents the file descriptor. Some of the values of FDs are,
cwd – Current Working Directory
txt – Text file
mem – Memory mapped file
mmap – Memory mapped device
NUMBER – Represent the actual file descriptor. The character after the number i.e ‘1u’, represents the mode in which the file is opened. r for read, w for write, u for read and write.
TYPE – Specifies the type of the file. Some of the values of TYPEs are,
REG – Regular File
DIR – Directory
FIFO – First In First Out
CHR – Character special file 

**Hardware**

 - hardware info:
dmidecode
 
 - hardware digest:
demsg
