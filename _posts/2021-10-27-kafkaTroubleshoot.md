---
layout: post
title: "Kafka Troubleshoot"
date: 2021-10-22 12:25:06
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
