---
layout: post
title: "Kafka Sniffer"
date: 2017-05-21 12:25:06
description: Kafka Sniffer
tags: 
 - kafka
---

**Kafka Sniffer**

 - Code:

[kafka_sniffer_code](https://github.com/foreversunyao/Kafka-related/blob/master/kafka_sniffer_v4.py)

 - Usage:

python kafka_sniffer_v4.py -t all -s 0.0.0.0 -p 9092
topic: all
source: 0.0.0.0
port: 9092
From 10.10.52.22 producer-41 Topic: sa-logger-syslog
sa-logger-syslog
From 10.10.52.66 producer-64 Topic: sa-logger-syslog
sa-logger-syslog
From 10.10.16.36 Fetch: ReplicaFetcherThread-0-4
sa-logger-winlog
