---
layout: post
title: "Kafka Troubleshoot"
date: 2022-03-22 12:25:06
description: Troubleshoot
tags: 
 - kafka
---

** Comsumer group is rebalancing.
[refer](https://medium.com/bakdata/solving-my-weird-kafka-rebalancing-problems-c05e99535435)


** dumping log segment
```
kafka-run-class.sh kafka.tools.DumpLogSegments --files xxx.log
kafka-run-class.sh kafka.tools.DumpLogSegments --files xxx.index, xxx.log // validate the index file 
```

** skew topic
- (lastest offset - earlies offset) per partitions
- changed the keys

** JVM
use G1 instead of CMS

** too many partitions
leader election will take 5ms for one partition, and initializing the metadata from zookeeper will take 2ms per partitions, so it will take more time to recovery if setting up many partitions in one topic
[refer](https://www.confluent.io/blog/how-choose-number-topics-partitions-kafka-cluster/)

** killing a partition move
- the normal operational flow for a partition reassignment is:
1. reassignment is requested(zookeeper node is created)
2. cluster controller adds partitions to new brokers being added
3. new brokers begin replicating each partition until it's in-sync
4. cluster controller removes the old brokers from the partitoin replica list.

- if any exception happened in this flow, it's possible to make the cluster lose  the existing reassignment:
```
remove /admin/reassign_partitions from zk node
foce a controller move
```

** isr not in sync,  Invalid, cause: Record is corrupt
[refer](https://stacksoft.io/blog/kafka-troubles/)

** broker connects zookeepr timeout
- disk IO
- CPU
- GC
- Network

** broker restarting takes long time
- starting need load log segments and rebuild index

** Unclean leader election
[refer](https://issues.apache.org/jira/browse/KAFKA-3410)


** stale metadata org.apache.kafka.common.errors.TimeoutException: 
Timeout of 60000ms expired before the position for partition p1 could be determined

The controller node is in charge of updating topic metadata. If leadership of a topic partition has moved, a consumer will not be able to read it if it does not know which broker is the current leader for the partition. Stale metadata means the controller node isn't doing its job and should be replaced.
zkCli.sh delete /controller to force a new controller elected

** consumer group lag 
coordinator failed to update with latest consumer group info, have to restart the coordinator to force consumer group rebalance again

** NotLeaderForPartitionException
adjust producer retry and retry.backoff
