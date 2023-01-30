---
layout: post
title: "Kafka Troubleshoot"
date: 2022-03-22 12:25:06
description: Troubleshoot
tags: 
 - kafka
---

# Comsumer group is rebalancing.
[refer](https://medium.com/bakdata/solving-my-weird-kafka-rebalancing-problems-c05e99535435)


# Improving Network utilizaiton when reassigning replicas
it is the best practice to shutdown and restart the broker before starting the reassignment, it will increase the performance and reduce the impact on the cluster as the replication traffic will be distributed to many brokers.

# dumping log segment
```
kafka-run-class.sh kafka.tools.DumpLogSegments --files xxx.log
kafka-run-class.sh kafka.tools.DumpLogSegments --files xxx.index, xxx.log // validate the index file 
```

# skew topic
- (lastest offset - earlies offset) per partitions
- changed the keys
# JVM
use G1 instead of CMS

# too many partitions
leader election will take 5ms for one partition, and initializing the metadata from zookeeper will take 2ms per    partitions, so it will take more time to recovery if setting up many partitions in one topic
[refer](https://www.confluent.io/blog/how-choose-number-topics-partitions-kafka-cluster/)

# killing a partition move
- the normal operational flow for a partition reassignment is:
1. reassignment is requested(zookeeper node is created)
2. cluster controller adds partitions to new brokers being added
3. new brokers begin replicating each partition until it's in-sync
4. cluster controller removes the old brokers from the partitoin replica list.
- if any exception happened in this flow, it's possible to make the cluster forget about the existing reassignment:
```
remove /admin/reassign_partitions from zk node
foce a controller move
```

# isr not in sync Invalid, cause: Record is corrupt
[refer](https://stacksoft.io/blog/kafka-troubles/)

# broker connects zookeepr timeout
- disk IO
- CPU
- GC
- Network

# broker restarting takes long time
- starting need load log segments and rebuild index

# Unclean leader election
[refer](https://issues.apache.org/jira/browse/KAFKA-3410)


# stale metadata org.apache.kafka.common.errors.TimeoutException: Timeout of 60000ms expired before the position for partition p1 could be determined

The controller node is in charge of updating topic metadata. If leadership of a topic partition has moved, a consumer will not be able to read it if it does not know which broker is the current leader for the partition. Stale metadata means the controller node isn't doing its job and should be replaced.
zkCli.sh delete /controller to force a new controller elected

# consumer group lag 
coordinator failed to update with latest consumer group info, have to restart the coordinator to force consumer group rebalance again

# Tunning
1. OS
- page cache(Memory)
- disable swapping(vm.swappiness=1, preferably 1, for minimum swapping on systems where the RHEL kernel is 2.6.32-642.el6 or higher.)
- tcp connections
- jvm(gc, heap, MaxGCPauseMillis, InitiatingHeapOccupancyPercent)
- dirty pages
2. Disk(Throughput and Capacity)
- JBOD VS raid 10
- ext, xfs
- ssd
- mount with noatime, be default, atime is updated every time a file is read(access time)
3. Network
- send and receive buffer size per socket(net.core.wmem_default, net.core.rmem_default )
- tcp window scaling(tcp_window_scaling)
- number of simultaneous connections to be accepted(net.core.netdev_max_backlog)
- in different rack
4. monitoring
- cpu
- network metrics
- file handle
- disk usage
- disk io
- gc
- zk
- UnderReplicatedPartitions
- PartitionCount,LeaderCount
- IsrExpandsPerSec
- Message in rate/Byte in rate/Byte out rate
- NetworkProcessorAvgIdlePercent
- RequestHandlerAvgIdlePercent
5. replication
- replica.lag.time.max.ms
- num.replica.fetchers
- min.insync.replica
6. broker
- log.retention.{ms, minutes, hours} , log.retention.bytes
- message.max.bytes, replica.fetch.max.bytes
- unclean.leader.election.enable
- min.insync.replicas
- replica.lag.time.max.ms
- replica.fetch.response.max.bytes
- zookeeper.session.timeout.ms
- num.io.threads
- log.segment.bytes(As messages are produced to Kafka , they are appended to the current log segment for the partition. A smaller log-segment     +++size means that files must be closed and allocated more often, which reduces the overall efficiency of disk writes; too larger means cant be   +++expired until log segment is closed.)
7. producer
- buffer.memory
- batch.size
- linger.ms
- max.in.flight.requests.per.connection
- compression.type
- acks
- avoid large message
8. consumer
- offsets.topic.replication.factor
- offsets.retention.minutes
- \__consumer_offsets
- fetch.min.bytes, fetch.max.wait.ms
- max.poll.interval.ms
- max.poll.records
- session.timeout.ms
- max.partition.fetch.bytes
- auto.offset.reset
- enable.auto.commit
- receive.buffer.bytes and send.buffer.bytes
