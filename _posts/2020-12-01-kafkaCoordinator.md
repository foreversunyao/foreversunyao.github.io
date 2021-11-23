---
layout: post
title: "Kafka Coordinator"
date: 2020-12-01 12:25:06
description: consumer group, Coordinator, Group management, Conumser, Rebalance Protocol
tags: 
 - kafka
---

**Coordinator**
1. consumer group
 A consumer group is the mechanism provided by Kafka to group multiple consumer clients, into one logical group, in order to load balance the consumption of partitions. Kafka provides the guarantee that a topic-partition is assigned to only one consumer within a group.

2. consumer group coordinator is one of the brokers, which receives heartbeats(or polling for messages) from all consumers of a consumer group. Each consumer group has a group coordinator.if a consumer stops sending heartbeats, the coordinator will trigger a rebalance.
3. coordinator vs group leader
When a consumer wants to join a consumer group, it sends a JoinGroup request to the group coordinator. The first consumer to join the group becomes the group leader. The leader receives a list of all consumers in the group from the group coordinator (this will include all consumers that sent a heartbeat recently and are therefore considered alive) and it is responsible for assigning a subset of partitions to each consumer. It uses an implementation of the PartitionAssignor interface to decide which partitions should be handled by which consumer.
After deciding on the partition assignment, the consumer leader sends the list of assignments to the GroupCoordinator which sends this information to all the consumers. Each consumer only sees his own assignment - the leader is the only client process that has the full list of consumers in the group and their assignments. This process repeats every time a rebalance happens

**Group management**
- join group
- sync group
- heartbeat [refer](https://chrzaszcz.dev/2019/06/kafka-heartbeat-thread/)
- leave group 

**Rebalance Protocol**
If a consumer leaves the group after a controlled shutdown or crashes then all its partitions will be reassigned automatically among other consumers. In the same way, if a consumer (re)join an existing group then all partitions will be also rebalanced between the group members.

- Group memegership protocol
- Client embedded protocol

**Rebalancing**
![img]({{ '/assets/images/kafka/kafka_consumer_rebalance.png' | relative_url }}){: .center-image }*(°0°)*

**limitation**
The first limitation of the rebalance protocol is that we cannot simply rebalance one member without stopping the whole group (stop-the-world effect).

**Static Memebership**
[refer](https://cwiki.apache.org/confluence/display/KAFKA/KIP-345%3A+Introduce+static+membership+protocol+to+reduce+consumer+rebalances)

**issue**
- https://github.com/spring-projects/spring-kafka/issues/1223
max.poll.records
max.poll.interval.ms

- heartbeat failed for group because it's rebalancing [refer](https://stackoverflow.com/questions/40162370/heartbeat-failed-for-group-because-its-rebalancing)
Heartbeats are the basic mechanism to check if all consumers are still up and running. If you get a heartbeat failure because the group is rebalancing, it indicates that your consumer instance took too long to send the next heartbeat and was considered dead and thus a rebalance got triggered.
session.timeout.ms up
heartbeat.interval.ms down
max.poll.records down



[refer1](https://medium.com/streamthoughts/apache-kafka-rebalance-protocol-or-the-magic-behind-your-streams-applications-e94baf68e4f2)
[refer2](https://www.confluent.io/blog/cooperative-rebalancing-in-kafka-streams-consumer-ksqldb/)
[refer3](https://www.confluent.io/blog/tutorial-getting-started-with-the-new-apache-kafka-0-9-consumer-client/)
