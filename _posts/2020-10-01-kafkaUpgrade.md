---
layout: post
title: "Kafka Upgrade"
date: 2020-10-01 12:25:06
description: Kafka Upgrade
tags: 
 - kafka
---

[UPGRADE GUIDE AND API CHANGES](https://kafka.apache.org/20/documentation/streams/upgrade-guide)

[Upgrade procedures](https://docs.confluent.io/current/installation/upgrade.html#upgrade-procedures)
1. set protocol and log as existing version
2. upgrade binary one broker by one
3. set protocol to latest one by one broker
4. upgrade kafka client
5. set log format to latest one by one broker
6. verify
```
inter.broker.protocol.version
log.message.format.version
```

[Upgrade Validation](https://www.jesseyates.com/2019/10/04/kafka-upgrade.html)
