---
layout: post
title: "Kafka New Features"
date: 2022-06-03 12:25:06
description: Kafka New Features
tags: 
 - kafka
---

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
