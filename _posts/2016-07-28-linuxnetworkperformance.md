---
layout: post
title: "Network Performance"
date: 2016-06-21 17:25:06
description: Network Performance
tags: 
 - linux
---

**Metrics**
 - bits per second
Network engineers most often refer to the performance of network devices by using the speed of the interfaces expressed in bits per second (b/s).

 - packets per second
Network devices receive and forward packets through physical interfaces that employ Layer 2 technologies, such as Ethernet and Packet Over SONET (POS) framing.

 - connections per second
Connections per second (c/s) refers to the rate at which a device can establish state parameters for new connections. As previously noted, a stateful device must create and manage connection information on all unique IP streams that transit the device. Typically, the device must handle the first packet of a new connection differently than all subsequent packets so that the device can establish the state parameters for the new connection. Because this process is specialized, it usually occurs in the software process of the devices, as opposed to the normal hardware-based forwarding process. The rate at which a device can establish state for new connections is related to factors such as processor (CPU) speed, memory speed, architecture, TCP/IP stack efficiency, etc.

 - transactions per second
Transactions per second (t/s) refers to the number of complete actions of a particular type that can be performed per second. The t/s measurement refers to more than just the processing of a single packet or even the setup of a new connection; it refers to the completion of a full cycle of a specific action. 

 - maximum concurrent connections
Maximum concurrent connections (mcc) refers to the total number of sessions (connections) about which a device can maintain state simultaneously. This value is mainly related to the amount of memory that is dedicated to this task. 

**Network Device**
stateless devices: routers and switcheds -- b/s and p/s
state devices: firewalls, intrusion prevention systems and load balancers  -- c/s and mcc

**Relationship of Bandwidth and Packet Forwarding Rate**
![img]({{ '/assets/images/linux/BandwidthFrame.png' | relative_url }}){: .center-image }*(°0°)*

