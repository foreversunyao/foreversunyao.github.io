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


**Kafka Internal**

![img]({{ '/assets/images/kafka/Kafka-broker-internals.png' | relative_url }}){: .center-image }*(°0°)*
