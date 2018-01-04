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



**Configuration**

 - Server configration template
https://github.com/foreversunyao/Kafka-related/blob/master/server.properties.template


 - Start and Stop service scripts
https://github.com/foreversunyao/Kafka-related/blob/master/kafka-server



