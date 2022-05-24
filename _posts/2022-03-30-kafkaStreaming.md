---
layout: post
title: "Kafka Streaming"
date: 2022-03-30 12:25:06
description: Kafka Streaming
tags: 
 - kafka
---

# what is streaming
- data stream is an abstraction representing an unbounded dataset. infinite and ever growing; event streams are ordered, immutable data records, event streams are replayable.
# kafka has stream processing
- kafka can support stream processing, like processing or transformaion capabilites; consumer, process and produce events  without relying on an external processing framework. data bus/integration + process
# concepts
- time(event time, log append time, processing time)
- state(store middle stage info, like counting the number of events by type involve multiple events; local state, external state); 
- Stream-table duality(contains current state and the a history of changes)
- time windows(size of the window; how often the window moves; how long the window remains updatable)
