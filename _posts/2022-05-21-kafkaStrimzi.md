---
layout: post
title: "Kafka Strimzi"
date: 2022-005-21 12:25:06
description: Kafka Strimzi
tags: 
 - kafka
---
## Quick start
1. download from https://github.com/strimzi/strimzi-kafka-operator/releases or git clone https://github.com/strimzi/strimzi-kafka-operator.git
2. change default namespace to your customised 
```
sed -i 's/namespace: .*/namespace: kafka/' install/cluster-operator/*RoleBinding*.yaml
```
3. change kafka namespace in install/cluster-operator/060-Deployment-strimzi-cluster-operator.yaml
```
env:
- name: STRIMZI_NAMESPACE
  value: sam-strimzi-kafka
```
4. deploy CRDs and RBAC resources
```
kubectl create -f install/cluster-operator/ -n sam-strimzi-kafka
```
5. create kafka cluster
```
apiVersion: kafka.strimzi.io/v1beta2
kind: Kafka
metadata:
  name: sam-strimzi-kafka
spec:
  kafka:
    replicas: 1
    listeners:
      - name: plain
        port: 9092
        type: internal
        tls: false
      - name: tls
        port: 9093
        type: internal
        tls: true
        authentication:
          type: tls
      - name: external
        port: 9094
        type: nodeport
        tls: false
    storage:
      type: persistent-claim
      size: 100Gi
      deleteClaim: false
      class: standard
    config:
      offsets.topic.replication.factor: 1
      transaction.state.log.replication.factor: 1
      transaction.state.log.min.isr: 1
      default.replication.factor: 1
      min.insync.replicas: 1
  zookeeper:
    replicas: 1
    storage:
      type: persistent-claim
      size: 100Gi
      deleteClaim: false
      class: standard
  entityOperator:
    topicOperator: {}
    userOperator: {}
```
6. create topic
```
apiVersion: kafka.strimzi.io/v1beta2
kind: KafkaTopic
metadata:
  name: my-topic
  labels:
    strimzi.io/cluster: "my-cluster"
spec:
  partitions: 3
  replicas: 1
```
7. ingress or NodePort to access kafka in k8s or kubectl exec
```
 kubectl exec -i -t sam-testing-kafka-cluster-kafka-0 -n sam-kafka
```

## Strimzi
Strimzi supports kafka using Operators to deploy and manage the componenets and edependencies of Kafka to Kubernetes.
# Components
- zookeeper
brokers registration, heartbeat to keep the broker list updated
maintaining a list of topics
performs leader election
access control(topics, consumer groups, users)
- kafka cluster
- kafka connect
source connector: pushes external data into kafka
sink connector: extracts data out of Kafka
- kafka exporter
extracts data for analysis  as prometheus metrics, including offsets, consumer groups, consumer lgs and topics
- kafka mirrormaker
mirror or replicate topics from one Kafka cluster to another, rely on kafka connect framework
- curise control

- cluster operator
kafka (including ZooKeeper, Topic Operator, User Operator, Kafka Exporter, and Cruise Control)
kafka connect
kafka mirrormaker
kafka bridge
- entity operator
- topic operator
- user operator


## on AWS
- storage optimized, i3, d3, h1
- node affinity to let kafka brokers running on these nodes
- anti-affnity to let kafka brokers and zookeeper run on separate nodes

## zookeeper performance
- low latency
- SSD
- separate disk for snapshots and logs
- high performance network
- reasonsoble number of zk servers
- isolation of zk from other processes

## JVM
- only requests , without limits
[refer](https://home.robusta.dev/blog/stop-using-cpu-limits/)

## Volume sizing and retention period
- JBOD 
use multiple disks in each Kafka broker for storing commit log
- Persistent-claim

## High availability
- replication
ack:0,1,2
- rack awareness
- disaster recovery 
multi-region strategy that services are deployed with backup in geographically distributed data centers.

## optimum partition count
the creation of more partition for a topic is directly dependent on available threads and disk

## security configs
- encrypted
Communication is always encrypted between brokers, zookeepers, operators, exporter
- authZ, authN

## other configs
- open file handlers
- max message size
- compression.type


## Kafka auto-scaler in KEDA
- rely on consumer groups and message retention by brokers
- consumer scaler thing if too many qps on producer side, trigger is lagRhreshold

## connection from outside the k8s
- route - to use OpenShift routes and the default HAProxy router
- loadbalancer - to use loadbalancer services
- nodeport - to use ports on Kubernetes nodes (external access)
- ingress - to use Kubernetes Ingress and the NGINX Ingress Controller for Kubernetes.
```
# ...
listeners:
# ...
  - name: external
    port: 9094
    type: route/nodeport/loadbalancer/ingress (any one of them)
    tls: true
# ...
```

## Monitoring
- JMX
- prometheus JMX Exporter
it takes the JMX metrics and exposes them as prometheus endpoint
- kafka exporter
- strimzi canary
- burrow for consumer lag
