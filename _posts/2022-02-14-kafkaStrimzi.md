---
layout: post
title: "Kafka Strimzi"
date: 2021-11-14 12:25:06
description: Strimzi, operator, kubernetes
tags: 
 - kafka
---
## Strimzi
- [refer](https://snourian.com/kafka-kubernetes-strimzi-part-1-creating-deploying-strimzi-kafka/)

1. contains
```
Kafka. A cluster of Kafka broker nodes
ZooKeeper. Storing configuration data and cluster coordination
Kafka Connect. An integration toolkit for streaming data between Kafka brokers and external systems using Connector (source and sink) plugins. (Also supports Source2Image)
Kafka MirrorMaker. Replicating data between two Kafka clusters, within or across data centers.
Kafka Bridge. Providing a RESTful interface for integrating HTTP-based clients with a Kafka cluster without the need for client applications to understand the Kafka protocol
Kafka Exporter. Extracting data for analysis as Prometheus metrics like offsets, consumer groups, consumer lag, topics and…
```
2. Operators
```
Cluster Operator. Deploys and manages Apache Kafka clusters, Kafka Connect, Kafka MirrorMaker, Kafka Bridge, Kafka Exporter, and the Entity Operator
Entity Operator. Comprises the Topic Operator and User Operator
Topic Operator. Manages Kafka topics.
User Operator. Manages Kafka users.
```
3. Persistent Cluster
Persistent Cluster. Uses PersistentVolumes to store ZooKeeper and Kafka data. The PersistentVolume is claimed using a PersistentVolumeClaim to make it independent of the actual type of the PersistentVolume. Also, the PersistentVolumeClaim can use a StorageClass to trigger automatic volume provisioning.
