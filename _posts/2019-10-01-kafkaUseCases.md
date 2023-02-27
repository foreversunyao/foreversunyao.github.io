---
layout: post
title: "Kafka Use Cases"
date: 2019-10-01 12:25:06
description: Kafka Use Cases, Exactly Once
tags: 
 - kafka
---
[excatly once](https://www.confluent.io/blog/chain-services-exactly-guarantees/)
[transaction api](https://www.confluent.io/blog/transactions-apache-kafka/)
```
 Each producer is given an identifier, and each message is given a sequence number. The combination of the two uniquely defines each batch of messages sent. The broker uses this unique sequence number to work out if a message is already in the log and discards it if it is.
 a Transactions API is layered on top, to handle the read side, as well as chaining together subsequent calls atomically.
```
