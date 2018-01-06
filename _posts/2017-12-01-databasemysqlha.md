---
layout: post
title: "Database MySQL HA"
date: 2017-12-01 20:25:06
description: MySQL HA,Proxy,Cluster 
tags: 
 - database
---

**MySQL HA**
High availability environments provide substantial benefit for databases that must remain available.

**MySQL Slave HA**

 - load balancer: HAProxy, ELB, SQL-aware proxy

**MySQL Master HA**
 - MHA
 - MMM
 - Cluster

**MySQL HA between Datacenter**

 - DNS
 - Semi-sync(if you don't want to loss any data)


**A HA Design demo**

![img]({{ '/assets/images/database/MySQL-HA-2.png' | relative_url }}){: .center-image }*(°0°)*
