---
layout: post
title: "Kafka Internel"
date: 2016-09-10 12:25:06
description: Apache Kafka Internel
tags: 
 - kafka
---

Kafka is a messaging system, and it is
Reliability Kafka is distributed, partitioned, replicated, and fault tolerant. Kafka replicates data and is able to support multiple subscribers. Additionally, it automatically balances consumers in the event of failure.
Scalability Kafka is a distributed system that scales quickly and easily without incurring any downtime.
Durability Kafka uses a distributed commit log, which means messages persists on disk as fast as possible providing intra-cluster replication, hence it is durable.
Performance Kafka has high throughput for both publishing and subscribing messages. It maintains stable performance even when dealing with many terabytes of stored messages.


**Kafka Component**

 - Zookeeper

 Apache Kafka uses Apache ZooKeeper to maintain and coordinate the Apache Kafka brokers.

 - Broker

 A Kafka cluster consists of one or more servers, each of which is called a broker. Producers send messages to the Kafka cluster, which in turn serves them to consumers. Each broker manages the persistence and replication of message data.

 - Producer

 Producers are processes that publish messages to one or more Kafka topics. The producer is responsible for choosing which message to assign to which partition within a topic. Assignment can be done in a round-robin fashion to balance load, or it can be based on a semantic partition function.

 - Consumer

 Consumers are processes that subscribe to one or more topics and process the feeds of published messages from those topics. Kafka consumers keep track of which messages have already been consumed by storing the current offset. Because Kafka retains all messages on disk for a configurable amount of time, consumers can use the offset to rewind or skip to any point in a partition.

```
❯ kafka-consumer-groups --bootstrap-server kafka.service.host:9092 --group groupA --describe --state
GROUP                                 COORDINATOR (ID)          ASSIGNMENT-STRATEGY  STATE           #MEMBERS
groupA         broker0001::9092 (xx) roundrobin 
```

**Client api**
 - consumer group coordinator
The group coordinator is nothing but one of the brokers which receives heartbeats (or polling for messages) from all consumers of a consumer group. Every consumer group has a group coordinator. If a consumer stops sending heartbeats, the coordinator will trigger a rebalance.
 - group leader
When a consumer wants to join a consumer group, it sends a JoinGroup request to the group coordinator. The first consumer to join the group becomes the group leader. The leader receives a list of all consumers in the group from the group coordinator (this will include all consumers that sent a heartbeat recently and are therefore considered alive) and it is responsible for assigning a subset of partitions to each consumer. It uses an implementation of the PartitionAssignor interface to decide which partitions should be handled by which consumer.

[...] After deciding on the partition assignment, the consumer leader sends the list of assignments to the GroupCoordinator which sends this information to all the consumers. Each consumer only sees his own assignment - the leader is the only client process that has the full list of consumers in the group and their assignments. This process repeats every time a rebalance happens.
[refer](https://stackoverflow.com/questions/42015158/what-is-the-difference-in-kafka-between-a-consumer-group-coordinator-and-a-consu)
[consumer options](https://docs.cloudera.com/runtime/7.2.1/kafka-developing-applications/topics/kafka-develop-consumers.html) 
**Kafka Internal**

![img]({{ '/assets/images/kafka/Kafka-broker-internals.png' | relative_url }}){: .center-image }*(°0°)*
