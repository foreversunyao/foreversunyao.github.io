---
layout: post
title: "Consul based DNS"
date: 2016-07-21 12:25:06
description: Consul DNS Service Discovery
tags: 
 - devops
---

**Consul based DNS and Auto Failover**

 - dnsmasq search dns from consul
echo “server=/consul/127.0.0.1#8600”>>/etc/dnsmasq.d/10-consul

![img]({{ '/assets/images/devops/Smart-DNS-based-on-consul-and-dnsmasq.jpg' | relative_url }}){: .center-image }*(°0°)*
