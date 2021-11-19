---
layout: post
title: "Kafka Commands"
date: 2016-11-12 12:25:06
description: Apache Kafka and Zookeeper Commands, troubleshoot
tags: 
 - kafka
---

 - Apache Kafka Commands

#Topic:
bin/kafka-topics --list --zookeeper 127.0.0.1:2181   bin/kafka-topics.sh -zookeeper 127.0.0.1:2181 -describe -topic test1
bin/kafka-topics.sh --zookeeper 127.0.0.1:2181 --create --topic test1 --partitions 1000 --replication-factor 1
bin/kafka-topics.sh –zookeeper 127.0.0.1:2181 –alter –partitions 20 –topic test1
bin/kafka-reassign-partitions.sh --topics-to-move-json-file topics-to-move.json --broker-list "171" --zookeeper 127.0.0.1:2181 --execute
cat topic-to-move.json
{"topics":
[{"topic": "test1"}],
"version":1
}
bin/kafka-topics.sh --delete --zookeeper 127.0.0.1:2181 --topic test1

#Producer:     
bin/kafka-console-producer --broker-list 127.0.0.1:9092--topic test1

#Consumer:
bin/kafka-console-consumer --zookeeper 127.0.0.1:2181 --topic test1
kafka-consumer-groups --bootstrap-server kafka1:9092 --group consumer_group1  --topic topic1:p1 --reset-offsets --shift-by 1 --execute
kafka-consumer-groups --bootstrap-server kafka1:9092 --group consumer_group1 --describe --state

#Consumer throughput:
bin/kafka-consumer-perf-test.sh --zookeeper 127.0.0.1:2181 --messages 5000000 --topic test1 --threads 1

#Consumer offset:
bin/kafka-consumer-offset-checker --group testabc --topic test1 --zookeeper 127.0.0.1:2181
bin/kafka-consumer-groups --zookeeper 127.0.0.1:2181 --describe --group test1

#reassignment:

#get skew topic:
(lastest offset - earlies offset) per partitions

#leader rotate per topic:
part of reassignment 
 
 - Apache Zookeeper Commands
```
echo stat | nc 127.0.0.1 2181 
check leader or follower

echo ruok | nc 127.0.0.1 2181 
check if running

echo kill | nc 127.0.0.1 2181 
shutdown server

echo conf | nc 127.0.0.1 2181 
output the configuration

echo cons | nc 127.0.0.1 2181 
output all sessions and cons from client

echo envi | nc 127.0.0.1 2181 
output server env

echo reqs | nc 127.0.0.1 2181 
output request not processed

echo wchs | nc 127.0.0.1 2181 
output watch info

echo wchc | nc 127.0.0.1 2181 
output watch and session info

echo wchp | nc 127.0.0.1 2181 
output watch path and session

echo dump|nc 127.0.0.1 2181 
output session and temporary node not processed

[zk: localhost:2181(CONNECTED) 1] h  
ZooKeeper -server host:port cmd args
   stat path [watch]
   set path data [version]
   ls path [watch]
   delquota [-n|-b] path
   ls2 path [watch]
   setAcl path acl
   setquota -n|-b val path
   history
   redo cmdno
   printwatches on|off
   delete path [version]
   sync path
   listquota path
   rmr path
   get path [watch]
   create [-s] [-e] path data acl
   addauth scheme auth
   quit
   getAcl path
   close
   connect host:port
```

- troulbeshooting
1. stale metadata org.apache.kafka.common.errors.TimeoutException: Timeout of 60000ms expired before the position for partition p1 could be determined

The controller node is in charge of updating topic metadata. If leadership of a topic partition has moved, a consumer will not be able to read it if it does not know which broker is the current leader for the partition. Stale metadata means the controller node isn't doing its job and should be replaced.
zkCli.sh delete /controller to force a new controller elected

2. leaderrotate if leader got some problems, like bad disk

