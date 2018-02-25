---
layout: post
title: Zookeeper
date: 2017-04-11 09:25:06
description: zookeeper configuration
tags: 
 - devops
---

**JVM**
zookeeper/conf/Java.env
#!/bin/sh
export JAVA_HOME=/usr/java/jdk
# heap size MUST be modified according to cluster environment
export JVMFLAGS="-Xms8G -Xmx8G $JVMFLAGS"

**Zookeeper**

tickTime=2000
initLimit=10
syncLimit=5
dataDir=/opt/zookeeper-3.4.6/data
clientPort=2181
autopurge.snapRetainCount=3
autopurge.purgeInterval=24

maxClientCnxns=1000
minSessionTimeout=30000
maxSessionTimeout=60000

**Monitor**
zookeeper.bytes_outstanding
zookeeper.bytes_received
zookeeper.bytes_sent
zookeeper.connections
zookeeper.latency.avg
zookeeper.latency.max
zookeeper.latency.min
zookeeper.nodes
zookeeper.outstanding_request
zookeeper.zxid.count
zookeeper.zxid.epoch

**Some Commands**
echo mntr | nc localhost 2181
echo stat|nc localhost 2181
echo conf| nc localhost 2181
echo ruok| nc localhost 2181
