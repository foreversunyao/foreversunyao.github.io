---
layout: post
title: "Kafka Push vs. pull"
date: 2017-09-29 23:25:06
description: Message Queue Push vs Pull
tags: 
 - kafka
---


**Pull cons:**
1,May has a little delay, depends on pull rotate time
2,Client is thick
3,Need coordinate to load balancer
4,If no data in queue, client may pull  many useless request

**Pull pros:**
1,Pull is better in dealing with diversified consumers
2,Consumer can more effectively control the rate of consumption.
3,Easier batch implementation 

**Push cons:**
1,Once a transaction is sent - it's gone. No "recorded history"
2,Can't transform "massive sets of data" at once
3,Need db to storage status

**Push pros:**
1,Fast notice and instant transaction communication
2,Transaction by transaction / guaranteed delivery mechanisms
3,Client is thin


Push vs Pull:

Pull is good at massive traffic request message system.
Push is good at instant communication and not too much traffic
