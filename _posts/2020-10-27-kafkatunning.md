---
layout: post
title: "Kafka Troubleshoot"
date: 2018-03-22 12:25:06
description: Tunning
tags: 
 - kafka
---

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
