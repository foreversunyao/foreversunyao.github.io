---
layout: post
title: "Linux Network"
date: 2016-06-21 17:25:06
description: Linux Network
tags: 
 - linux
---

**ss command**
ss | less  
Netid  State      Recv-Q Send-Q   Local Address:Port       Peer Address:Port   
u_str  ESTAB      0      0                    * 15545                 * 15544  
u_str  ESTAB      0      0                    * 12240                 * 12241  
u_str  ESTAB      0      0      @/tmp/dbus-2hQdRvvg49 12726                 * 12159  
u_str  ESTAB      0      0                    * 11808                 * 11256  
u_str  ESTAB      0      0                    * 15204                 * 15205 

ss -ltp(pid and conn)

ss -t4 |awk '{print $1}'|sort |uniq -c

Display sockets with state x 
ss -t4 state x  
1. established
2. syn-sent
3. syn-recv
4. fin-wait-1
5. fin-wait-2
6. time-wait
7. closed
8. close-wait
9. last-ack
10. closing
11. all - All of the above states
12. connected - All the states except for listen and closed
13. synchronized - All the connected states except for syn-sent
14. bucket - Show states, which are maintained as minisockets, i.e. time-wait and syn-recv.
15. big - Opposite to bucket state.

**interface**
ip link add
ip link show
ip link del docker0

**Socket**
It is the socket pair (the 4-tuple consisting of the client IP address, client port number, server IP address, and server port number) that specifies the two endpoints that uniquely identifies each TCP connection in an internet. 


For tcp:
Clinet:
The steps involved in establishing a socket on the client side are as follows:
1,Create a socket with the socket() system call
2,Connect the socket to the address of the server using the connect() system call
3,Send and receive data. There are a number of ways to do this, but the simplest is to use the read() and write() system calls.

Server:
1,Create a socket with the socket() system call
2,Bind the socket to an address using the bind() system call. For a server socket on the Internet, an address consists of a port number on the host machine.
3,Listen for connections with the listen() system call
4,Accept a connection with the accept() system call. This call typically blocks until a client connects with the server.
5,Send and receive data

Often, the servicing of a request on behalf of a client may take a considerable length of time. It would be more efficient in such a case to accept and deal with new connections while a request is being processed. The most common way of doing this is for the server to fork a new copy of itself after accepting the new connection.

For udp:
Clinet:
The socket() API returns a socket descriptor, which represents an endpoint. The statement also identifies that the Internet Protocol version 6 address family (AF_INET6) with the UDP transport (SOCK_DGRAM) is used for this socket.
In the client example program, the getaddrinfo() API is used to retrieve the IP address of the server. getaddrinfo() handles a server string that is passed as a valid IPv6 address string or a host name of the server.
Use the sendto() API to send the data to the server.
Use the recvfrom() API to receive the data from the server.
The close() API ends any open socket descriptors.

Server:
The socket() API returns a socket descriptor, which represents an endpoint. The statement also identifies that the Internet Protocol version 6 address family (AF_INET6) with the UDP transport (SOCK_DGRAM) is used for this socket.
After the socket descriptor is created, a bind() API gets a unique name for the socket. In this example, the user sets the s6_addr to zero, which means that the UDP port of 3555 is bound to all IPv4 and IPv6 addresses on the system.
The server uses the recvfrom() API to receive that data. The recvfrom() API waits indefinitely for data to arrive.
The sendto() API echoes the data back to the client.
The close() API ends any open socket descriptors.

**ISO**

![img]({{ '/assets/images/linux/ISO.png' | relative_url }}){: .center-image }*(°0°)*


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

UDP is used when speed is desirable and error correction isn’t necessary. For example, UDP is frequently used for live broadcasts and online games, and it is used by DNS, DHCP, TFTP, SNMP, RIP, VOIP.

TCP – is for connection orientated applications. It has built in error checking and will re transmit missing packets and it used by HTTP, HTTPs, FTP, SMTP, Telnet protocols.

UDP – is for connection less applications. It has no has built in error checking and will not re transmit missing packets.

![img]({{ '/assets/images/linux/tcp_udp.png' | relative_url }}){: .center-image }*(°0°)*

**ICMP**

![img]({{ '/assets/images/linux/ICMP-head.png' | relative_url }}){: .center-image }*(°0°)*

disable ping command: echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all

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


**Network conf**
lo: is a loopback device, a specific virtual interface, which system uses to communicate with itself. Thanks to lo, local applications can communicate with each other even without a network connection.
arp: allows us to look at the table of MAC-addresses the device knows and IP-addresses mapped to them.

**DHCP**
In case of DHCP, it happens like this:
A DHCP-client sends a broadcast message with a request "I need an IP-address"
A DHCP-server catches it and sends back also a broadcast message "I have an IP-address x.x.x.x, do you want it?"
The DHCP-client receives the message and sends another one: "Yes, I want the address x.x.x.x"
The DHCP-server answers "Ok, then x.x.x.x belongs to you"

VPN:
Different protocols: IP security,Layer 2 Tunnerling, Secure Sockets Layer/Transport Layer Security,Point-to-Point Tunneling Protocol,Secure Shell.
vpn client -(encrpted)-> vpn server(judge and permit or deny)


**RPS/RFS**
Receive Flow Steering (RFS) extends RPS behavior to increase the CPU cache hit rate and thereby reduce network latency. Where RPS forwards packets based solely on queue length, RFS uses the RPS backend to calculate the most appropriate CPU, then forwards packets based on the location of the application consuming the packet.  
