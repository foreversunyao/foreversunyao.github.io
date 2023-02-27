---
layout: post
title: "System Design"
date: 2022-02-25 10:25:06
description: Scalable Web Architecture and Distributed Systems
tags:
 - system
---

[refer](http://aosabook.org/en/distsys.html)

# Principles of Web Distributed Systems Design
- Availability
High availability in distributed systems requires the careful consideration of redundancy for key components, rapid recovery in the event of partial system failures, and graceful degradation when problems occur.
- Performance
creating a system that is optimized for fast responses and low latency is key.
- Reliability
Users need to know that if something is written to the system, or stored, it will persist and can be relied on to be in place for future retrieval.
- Scalability
Scalability can refer to many different parameters of the system: how much additional traffic can it handle, how easy is it to add more storage capacity, or even how many more transactions can be processed
- Manageability
Things to consider for manageability are the ease of diagnosing and understanding problems when they occur, ease of making updates or modifications, and how simple the system is to operate.
- Cost 
Cost is the total cost of ownership. hardware, software, people, effort of operation...

# Deisgn
1. Consider:  what are the right pieces, how these pieces fit together, and what are the right tradeoffs.
2. Redundancy and Parititon
3. Data Access: cache, proxies, indexes and load balancers
