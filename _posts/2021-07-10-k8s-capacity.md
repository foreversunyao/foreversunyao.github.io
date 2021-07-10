---
layout: post
title: "K8s capacity"
date: 2021-07-10 23:25:06
description: capacity, large clusters
tags:
 - k8s
---

- Considerations for large clusters
```
No more than 110 pods per node
No more than 5000 nodes
No more than 150000 total pods
No more than 300000 total containers
```

- Cloud provider resource quotas
```
Computer instances
CPUs
Storage volumes
In-use IP addresses
Packet filtering rule sets
Number of load balancers
Network subnets
Log streams
```

- Control plane components
apis
etcd storage

- Addon resources

[refer](https://kubernetes.io/docs/setup/best-practices/cluster-large/)
