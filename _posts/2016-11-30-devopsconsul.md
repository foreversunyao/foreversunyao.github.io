---
layout: post
title: Consul
date: 2016-11-30 09:25:06
description: Distributed, highly available tool for service discovery, configuration, and orchestration from hashicorp.
tags: 
 - devops
---

**Consul**
Consul has multiple components, but as a whole, it is a tool for discovering and configuring services in your infrastructure. 
Key features:
 - Service Discovery
Consul makes it simple for services to register themselves and to discover other services via a DNS or HTTP interface. Register external services such as SaaS providers as well.
 - Failure Detection
Pairing service discovery with health checking prevents routing requests to unhealthy hosts and enables services to easily provide circuit breakers.
 - Multi Datacenter
Consul scales to multiple datacenters out of the box with no complicated configuration. Look up services in other datacenters, or keep the request local.
 - KV Storage
Flexible key/value store for dynamic configuration, feature flagging, coordination, leader election and more. Long poll for near-instant notification of configuration changes.

![img]({{ '/assets/images/devops/consul_arch.png' | relative_url }}){: .center-image }*(°0°)*


Gossip - Consul is built on top of Serf which provides a full gossip protocol that is used for multiple purposes. Serf provides membership, failure detection, and event broadcast.

RPC - Remote Procedure Call. This is a request / response mechanism allowing a client to make a request of a server.

**Consensus Module**

![img]({{ '/assets/images/devops/consul_consensus.png' | relative_url }}){: .center-image }*(°0°)*

Follower:
Followers only respond to RPCs, but do not initiate any communication.

Candidate:
Candidates start a new election, incrementing the term, requesting a vote, and voting for themselves. Depending on the outcome of the election, become leader, follower (be outvoted or receive RPC from valid leader), or restart these steps (within a new term). Only a candidate with a log that contains all committed commands can become leader.

Leader:
The leader sends heartbeats (empty AppendEntries RPCs) to all followers, thereby preventing timeouts in idle periods. For every command from the client, append to local log and start replicating that log entry, in case of replication on at least a majority of the servers, commit, apply commited entry to its own leader state machine, and then return the result to the client. If logIndex is higher than the nextIndex of a follower, append all log entries at the follower using RPC, starting from the his nextIndex.

All of these roles have a randomized time-out, on the elapse of which all roles assume that the leader has crashed and convert to be candidates, triggering a new election and incrementing the current term.

Terms:
To mitigate problems with clock synchronization in asynchronous systems, where the messages – through which clock synchronization may be negotiated – can have arbitrary delays, Raft uses a logical clock in the form of terms. Logical time uses the insight that no exact notion of time is needed to keep track of causality in a system. Each server has its own local view of time that is represented by its currentTerm. This currentTerm number increases monotonically over time, meaning that it can only go up.
Every communication in Raft includes an exchange and comparison of currentTerms. A term is only updated when a server (re-)starts an election or when the currentTerm of the party that a server communicates with is higher than its own, in which case the term get’s updated with that higher value. Any communication attempt with a server of a higher term is always rejected and when a candidate or leader learns of a higher term than its own, it immediately returns to being a follower.

**Configuration**
[consul](https://github.com/foreversunyao/Scripts-and-Configuration_Example/blob/master/consul_config.json)
**Monitor**
[grafana](11)

**CommandsandTools**
