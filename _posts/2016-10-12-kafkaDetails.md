---
layout: post
title: "Kafka Details"
date: 2016-10-12 12:25:06
description: Apache Kafka Details
tags: 
 - kafka
---

 - Topic and Partition

A topic is a category or feed name to which records are published.
Each partition is an ordered, immutable sequence of records that is continually appended to—a structured commit log. The records in the partitions are each assigned a sequential id number called the offset that uniquely identifies each record within the partition, offset is java long type, so it is 2(63)-1. Partitions are distributed into different brokers.

 - Page cache and Sendfile

![img]({{ '/assets/images/kafka/sendfile.png' | relative_url }}){: .center-image }*(°0°)*
 
 - ISR

![img]({{ '/assets/images/kafka/kafka_isr.png' | relative_url }}){: .center-image }*(°0°)*

acks=0 If set to zero then the producer will not wait for any acknowledgment from the server at all. The record will be immediately added to the socket buffer and considered sent. No guarantee can be made that the server has received the record in this case, and theretries configuration will not take effect (as the client won't generally know of any failures). The offset given back for each record will always be set to -1.

acks=1 This will mean the leader will write the record to its local log but will respond without awaiting full acknowledgement from all followers. In this case should the leader fail immediately after acknowledging the record but before the followers have replicated it then the record will be lost.

acks=all This means the leader will wait for the full set of in-sync replicas to acknowledge the record. This guarantees that the record will not be lost as long as at least one in-sync replica remains alive. This is the strongest available 
