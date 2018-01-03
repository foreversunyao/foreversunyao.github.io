---
layout: post
title: "Linux Network"
date: 2016-06-21 17:25:06
description: Linux Network
tags: 
 - linux
---

**Netfilter System**

![img]({{ '/assets/images/linux/Iptables.jpg' | relative_url }}){: .center-image }*(°0°)*

**TCP**

![img]({{ '/assets/images/linux/TCP-connect.png' | relative_url }}){: .center-image }*(°0°)*

![img]({{ '/assets/images/linux/TCP-head.png' | relative_url }}){: .center-image }*(°0°)*

![img]({{ '/assets/images/linux/TCP-Three-shakehands.png' | relative_url }}){: .center-image }*(°0°)*

TCP works:
TCP is the most commonly used protocol on the Internet.

When you request a web page in your browser, your computer sends TCP packets to the web server’s address, asking it to send the web page back to you. The web server responds by sending a stream of TCP packets, which your web browser stitches together to form the web page. When you click a link, sign in, post a comment, or do anything else, your web browser sends TCP packets to the server and the server sends TCP packets back.

TCP is all about reliability—packets sent with TCP are tracked so no data is lost or corrupted in transit. This is why file downloads don’t become corrupted even if there are network hiccups. Of course, if the recipient is completely offline, your computer will give up and you’ll see an error message saying it can’t communicate with the remote host.

TCP achieves this in two ways. First, it orders packets by numbering them. Second, it error-checks by having the recipient send a response back to the sender saying that it has received the message. If the sender doesn’t get a correct response, it can resend the packets to ensure the recipient receives them correctly.

**HTTP**

![img]({{ '/assets/images/linux/HTTP-head.png' | relative_url }}){: .center-image }*(°0°)*

**UDP**

![img]({{ '/assets/images/linux/UDP-head.png' | relative_url }}){: .center-image }*(°0°)*

UDP works: The UDP protocol works similarly to TCP, but it throws out all the error-checking stuff. All the back-and-forth communication introduce latency, slowing things down.

When an app uses UDP, packets are just sent to the recipient. The sender doesn’t wait to make sure the recipient received the packet—it just continues sending the next packets. If the recipient misses a few UDP packets here and there, they are just lost—the sender won’t resend them. Losing all this overhead means the devices can communicate more quickly.

UDP is used when speed is desirable and error correction isn’t necessary. For example, UDP is frequently used for live broadcasts and online games.

**ICMP**

![img]({{ '/assets/images/linux/ICMP-head.png' | relative_url }}){: .center-image }*(°0°)*


**NAT**

Network Address Translation (NAT) is a deceptively simple concept. NAT is the technique of rewriting addresses on a packet as it passes through a routing device. There are far reaching ramifications on network design and protocol compatibility wherever NAT is used.

To set a linux machine as a router you need the following

1- Enable forwarding on the box with

echo 1 > /proc/sys/net/ipv4/ip_forward
Assuming your public interface is eth1 and local interface is eth0

2- Set natting the natting rule with:

iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
3- Accept traffic from eth0:

iptables -A INPUT -i eth0 -j ACCEPT
4- Allow established connections from the public interface.

iptables -A INPUT -i eth1 -m state --state ESTABLISHED,RELATED -j ACCEPT
5- Allow outgoing connections:

iptables -A OUTPUT -j ACCEPT

**KeepAlived**

Keepalived is a routing software written in C. The main goal of this project is to provide simple and robust facilities for loadbalancing and high-availability to Linux system and Linux based infrastructures. Loadbalancing framework relies on well-known and widely used Linux Virtual Server (IPVS) kernel module providing Layer4 loadbalancing. Keepalived implements a set of checkers to dynamically and adaptively maintain and manage loadbalanced server pool according their health. On the other hand high-availability is achieved by VRRP protocol. VRRP is a fundamental brick for router failover. In addition, Keepalived implements a set of hooks to the VRRP finite state machine providing low-level and high-speed protocol interactions. Keepalived frameworks can be used independently or all together to provide resilient infrastructures.

**Nginx**
![img]({{ '/assets/images/linux/Nginx-internal.png' | relative_url }}){: .center-image }*(°0°)*

![img]({{ '/assets/images/linux/Nginx.png' | relative_url }}){: .center-image }*(°0°)*

Kill old worker process(after reload): ps aux |grep "worker process is shutting down"|grep -v grep |awk {"print $2"}|xargs -r kill

Linux configuration for Nginx:
net.ipv4.tcp_max_tw_buckets=260000 -- permit how many TIME_WAIT sockets open, if system is strong, can use a big number.
net.ipv4.tcp_tw_reuse = 0 -- not use TIME_WAIT sockets
net.ipv4.tcp_tw_recycle = 1 -- recycle TIME_WAIT sockets quickly  --dangerous, better not to use this
net.ipv4.tcp_fin_timeout = 8 --- for recycle TIME_WAIT TCP AND PORT
net.ipv4.ip_local_port_range = 10000 65000 ---for port range
net.ipv4.tcp_max_syn_backlog = 8192 -- add queue for ack


