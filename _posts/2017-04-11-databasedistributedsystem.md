---
layout: post
title: "Distributed System(Ongoing)"
date: 2017-04-11 09:25:06
description: CAP, consistent, quorum, zab, raft, paxos, 2pc, gossip
tags: 
 - database
---

**CAP**


**consistent**

**quorum**
The W+R>N quorum solves the problem of sharing a single value among multiple servers.quorum can be used to implement a distributed log.
Can a situation occur in which a read doesn't return the most up-to-date value?
If R+W > N, then this situation is guaranteed not to occur.
There are N nodes that might hold the value. A write contacts at least W nodes - place a "write" sticker on each of these. A subsequent read contacts at least R nodes - place a "read" sticker on each of these. There are R+W stickers but only N nodes, so at least one node must have both stickers. That is, at least one node participates in both the read and the write, so is able to return the latest write to the read operation.

**2pc**
[refer](https://foreversunyao.github.io/2017/08/databasemysqlXA)
cons: may bad performance and too much constraint

**paxos**
A Paxos node can take on any or all of three roles: proposer, acceptor, and learner. A proposer proposes a value that it wants agreement upon. It does this by sending a proposal containing a value to the set of all acceptors, which decide whether to accept the value. Each acceptor chooses a value independently — it may receive multiple proposals, each from a different proposer — and sends its decision to learners, which determine whether any value has been accepted. 
Ongoing(a little hard to descripe the algorithm)
[refer](https://angus.nyc/2012/paxos-by-example/)

**zab**
Zookeeper Atomic Broadcast (ZAB) is the protocol under the hood that drives ZooKeeper replication order guarantee. It also handles electing a leader and recovery of failing leaders and nodes.
[refer1](https://distributedalgorithm.wordpress.com/2015/06/20/architecture-of-zab-zookeeper-atomic-broadcast-protocol/)
[refer2](https://blog.acolyer.org/2015/03/09/zab-high-performance-broadcast-for-primary-backup-systems/)

**raft**
Raft implements consensus by first electing a distinguished leader, then giving the leader complete responsibility for managing the replicated log. The leader accepts log entries from clients, replicates them on other servers, and tells servers when it is safe to apply log entries to their state machines.
[refer](https://blog.acolyer.org/2015/03/12/in-search-of-an-understandable-consensus-algorithm/)

**gossip**
A gossip protocol is a procedure or process of computer-computer communication that is based on the way social networks disseminate information or how epidemics spread. It is a communication protocol.
[refer](https://managementfromscratch.wordpress.com/2016/04/01/introduction-to-gossip/)

**compare**
![img]({{ '/assets/images/database/2pc_quorum.png' | relative_url }}){: .center-image }*(°0°)*
![img]({{ '/assets/images/database/consistency_compare.png' | relative_url }}){: .center-image }*(°0°)*
