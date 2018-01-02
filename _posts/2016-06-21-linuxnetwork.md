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
