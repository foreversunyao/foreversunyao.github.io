---
layout: post
title: "Kafka Monitor"
date: 2017-12-30 12:25:06
description: Apache Kafka Monitor and Grafana Template
tags: 
 - kafka
---


**Kafka metrics**

Avaiable:
 - UnderReplicatedPartitions: Number of under-replicated partitions. Alert when UnderReplicatedPartitions > 0.
   MBean Name: kafka_server_replicamanager_underreplicatedpartitions
 - UncleanLeaderElectionsRate: Number of disputed leader elections rate. Alert when UncleanLeaderElectionsPerSec != 0.
   MBean Name: LeaderElectionRateAndTimeMs 
 - OfflinePartitionsCount: Number of partitions without an active leader, therefore not readable nor writeable. Alert when OfflinePartitionsCount > 0.
   MBean Name: kafka_controller_kafkacontroller_offlinepartitionscount
 - ActiveControllers: Number of active controller brokers. Alert when ActiveControllerCount != 1.
   MBean Name: kafka_controller_kafkacontroller_activecontrollercount
 - IsrShrink/IsrExpands: When a broker goes down, ISR will shrink for some of the partitions. When that broker is up again, ISR will be expanded once the replicas have fully caught up.
   MBean Name: kafka_server_replicamanager_isrshrinks_total and kafka_server_replicamanager_isrexpands_total

Performance:
 - RequestQueue: Request Queue Size
   MBean Name: kafka_network_requestchannel_requestqueuesize
 - ResponseQueue: Response Queue Size
   MBean Name: kafka_network_requestchannel_responsequeuesize
 - LogFlushLatency: Asynchronous disk log flush and time in ms.
   MBean Name: LogFlushRateAndTimeMs
 - MessagesInPerSec: Incoming messages per second.
   MBean Name: kafka_server_brokertopicmetrics_messagesin_total 
 - BytesInPerSec: Incoming/outgoing bytes per second.
   MBean Name: kafka_server_brokertopicmetrics_bytesin_total 
 - BytesOutPerSec: Incoming/outgoing bytes per second.
   MBean Name: kafka_server_brokertopicmetrics_bytesout_total

Misc:
 - PurgatorySize: Number of requests waiting in producer purgatory, Number of requests waiting in fetch purgatory
   MBean Name: PurgatorySize 
 - NetworkProcessorAvgIdlePercent:  The average fraction of time the network processors are idle. Alert when NetworkProcessorAvgIdlePercent < 0.3.
   MBean Name: NetworkProcessorAvgIdlePercent 
 - LeaderCountsPerBroker: Number of Leader per broker
   MBean Name: kafka_server_replicamanager_leadercount
 - PartitionsPerBroker: Number of Partitions per broker
   MBean Name: kafka_server_replicamanager_partitioncount

**GC**
 - JVM Used: JVM Used
   MBean Name: jvm_memory_bytes_used
 - JVM GC TIME: 
   MBean Name: jvm_gc_collection_seconds_sum

**JVM**
 - ParNew count    ParNew     Number of young-generation collections
 - ParNew time     ParNew     Elapsed time of young-generation collections
 - ConcurrentMarkSweep count   ConcurrentMarkSweep        Number of old-generation collections
 - ConcurrentMarkSweep time

**HOST**
 - Page cache reads ratio  Ratio of reads from page cache vs reads from disk
 - Disk usage      Disk space currently consumed vs available
 - CPU usage       CPU use Resource: Utilization
 - Network bytes sent/received     Network traffic in/out

