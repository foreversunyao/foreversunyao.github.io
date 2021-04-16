---
layout: post
title: "Kafka MirrorMaker"
date: 2020-04-15 12:25:06
description: MirrorMaker, debug
tags: 
 - kafka
---

**MirrorMaker**
MirrorMaker is a stand-alone tool for copying data between two Apache Kafka clusters. It is little more than a Kafka consumer and producer hooked together.

The origin and destination clusters are completely independent entities: they can have different numbers of partitions and the offsets will not be the same. For this reason the mirror cluster is not really intended as a fault-tolerance mechanism (as the consumer position will be different). The mirror maker process will, however, retain and use the message key for partitioning so order is preserved on a per-key basis.


**example**
```
$ bin/kafka-run-class.sh kafka.tools.MirrorMaker --consumer.config consumer-1.properties \
   --consumer.config consumer-2.properties --producer.config producer.properties \
   --whitelist my-topic
```

**debug**
- lag
1, find the topic with the largest lag and its partitions with largest lags, try to rotate these partitions' leaders
2, heatbeat error 
3, rebalance when new consumer group comes
- validate the source and destination cluster of mm

- mirror_consumer_state

- jmx metrics
messages per topic and broker
bytes out per topic and broker
consumer response time per broker
- skew of topic partitions

- parameters
producer batch.size
max.poll.record(probably mirrormaker did not fetch enough messages)







