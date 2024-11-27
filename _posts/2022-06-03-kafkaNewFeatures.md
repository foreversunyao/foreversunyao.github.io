---
layout: post
title: "Kafka New Features(ongoing)"
date: 2024-06-03 12:25:06
description: Kafka New Features
tags: 
 - kafka
---

## 3.7.0
TODO

## 3.6.0
# Kafka Tiered Storage (Early Access)

# Accept duplicate listener on port for IPv4/IPv6

# Metadata Transactions for KRaft


## 3.5.0
# Rack-aware Partition Assignment for Kafka Consumers

# Replicas with stale broker epoch should not be allowed to join the ISR

## 3.4.0
# ZooKeeper to KRaft Migration
??

## 3.3.1
# Mark KRaft as Production Ready
# Monitor KRaft Controller Quorum health
# Exactly-Once support for source connectors

## 3.2.0
# Rack-aware standby task assignment in Kafka Streams 


## 3.1.0 
# Custom partitioners in foreign-key joins

## 3.0.0
# Kafka Raft support for snapshots of the metadata topic and other improvements in the self-managed quorum

# Optimizations in OffsetFetch and FindCoordinator requests


## 2.8.0
??

## 2.7.0
# Add TRACE-level end-to-end latency metrics to Streams
TODO
# Add Sliding-Window support for Aggregations
TODO


## 2.6.0
# Significant performance improvements for large numbers of partitions
TODO
# Kafka Streams support for emit on change
TODO
# New metrics for better operational insight
TODO


## 2.5.0
# Incremental rebalance for Kafka Consumer
TODO

## 2.4.0
# consuming messages from closest replicas 
[refer](https://developers.redhat.com/blog/2020/04/29/consuming-messages-from-closest-replicas-in-apache-kafka-2-4-0-and-amq-streams#is_the_rack_aware_selector_right_for_your_use_case_)
- features
1. KIP-392 implements a new broker plugin interface, ReplicaSelector, that lets you provide custom logic to determine which replica a consumer should use. You configure the plugin using the replica.selector.class option. Kafka provides two selector implementations. LeaderSelector always selects the leader replica, so messaging works exactly like it did before. LeaderSelector is also the default selector, so by default Kafka 2.4.0's messaging behavior is the same as in previous versions.
2. RackAwareReplicaSelector attempts to use the rack ID to select the replica that is closest to the consumer. 
3. Kafka already allows you to balance replicas across racks. You can use the broker.rack configuration to assign each broker a rack ID. Brokers will then try to spread replicas across as many racks as possible. This feature improves resiliency against rack failures.  AWS availability zones correspond to racks.
4. you can configure the new client.rack to assign a rack ID for consumers. When it is enabled, RackAwareReplicaSelector tries to match the consumer's client.rack with available broker.racks. It then selects the replica that has the same rack ID as the client.
- Benefits:  
1. Consuming messages from the closest replica could help reduce the load on your network. 
2. Has potential cost benefits for public cloud environments. data transfers are free between brokers and clients in the same availability zone. Data transfers across different availability zones are billed.
- Drawback:
1. the latency between the producer and the consumer will be higher when fetching from followers rather than a leader. 
