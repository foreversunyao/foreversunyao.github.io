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
