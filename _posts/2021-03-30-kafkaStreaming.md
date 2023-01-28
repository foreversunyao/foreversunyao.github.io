---
layout: post
title: "Kafka Streaming"
date: 2021-03-30 12:25:06
description: Kafka Streaming
tags: 
 - kafka
---

# what is streaming
- data stream is an abstraction representing an unbounded dataset. infinite and ever growing; event streams are ordered, immutable data records, event streams are replayable.
![img]({{ '/assets/images/kafka/apache-big-data-streaming-frameworks.png' | relative_url }}){: .center-image }*(°0°)*

# kafka has stream processing
- kafka can support stream processing, like processing or transformaion capabilites; consumer, process and produce events  without relying on an external processing framework. data bus/integration + process
[refer](https://developers.redhat.com/blog/2020/09/28/build-a-data-streaming-pipeline-using-kafka-streams-and-quarkus#)

![img]({{ '/assets/images/kafka/kafka-streaming-join.png' | relative_url }}){: .center-image }*(°0°)*


# concepts
- time(event time, log append time, processing time)
- state(store middle stage info, like counting the number of events by type involve multiple events; local state, external state); 
- Stream-table duality(contains current state and the a history of changes)
- time windows(size of the window; how often the window moves; how long the window remains updatable)

# streams vs consumer
[refer](https://www.baeldung.com/java-kafka-streams-vs-kafka-consumer)
![img]({{ '/assets/images/kafka/kafka-streaming-api.png' | relative_url }}){: .center-image }*(°0°)*


## on AWS
[refer](https://programmaticponderings.com/2021/09/09/getting-started-with-spark-structured-streaming-and-kafka-on-aws-using-amazon-msk-and-amazon-emr%EF%BF%BC/)
## spark on kakfa
[spark on kafka](https://blog.stratio.com/optimizing-spark-streaming-applications-apache-kafka/)

## flink
[component](https://nightlies.apache.org/flink/flink-docs-release-1.0/internals/general_arch.html)
[compare to kakfa stream](https://dzone.com/articles/kafka-stream-kstream-vs-apache-flink)
