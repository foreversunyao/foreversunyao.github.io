---
layout: post
title: "Kafka Best Practice"
date: 2016-11-20 12:25:06
description: Apache Best Practice(configuration,JVM)
tags: 
 - kafka
---

**JVM**

 - CMS gc:

export KAFKA_HEAP_OPTS="-server -Xmx16G -Xms16G -Xmn8G -XX:SurvivorRatio=6 -XX:CMSInitiatingOccupancyFraction=70 -XX:+UseCMSInitiatingOccupancyOnly"

 - G1 gc:

export KAFKA_HEAP_OPTS="-server -Xmx16g -Xms16g -XX:MetaspaceSize=96m -XX:+UseG1GC -XX:MaxGCPauseMillis=20 -XX:InitiatingHeapOccupancyPercent=35 -XX:G1HeapRegionSize=16M -XX:MinMetaspaceFreeRatio=50 -XX:MaxMetaspaceFreeRatio=80"

**Topic and partitions**

According the [article](https://www.confluent.io/blog/how-to-choose-the-number-of-topicspartitions-in-a-kafka-cluster/), leader election will take 5ms for one partition, and initializing the metadata from zookeeper will take 2ms per partitions, so it will take more time to recovery if setting up many partitions in one topic .
It’s probably a good idea to limit the number of partitions per broker to 100 x b x r, where b is the number of brokers in a Kafka cluster and r is the replication factor, so if we have 5 broker servers and 3 replications, we should set less 1500 in total partitions in one kafka cluster.


**Configuration**

 - Server configration template
https://github.com/foreversunyao/Kafka-related/blob/master/server.properties.template


 - Start and Stop service scripts
https://github.com/foreversunyao/Kafka-related/blob/master/kafka-server



