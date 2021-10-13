---
layout: post
title: "K8s debug scheduling"
date: 2021-10-13 23:25:06
description: debug kube pending pods and scheduling failures
tags:
 - k8s
---

[refer](https://www.datadoghq.com/blog/debug-kubernetes-pending-pods/#node-affinity-and-anti-affinity-rules)

**predicate**
[order](https://github.com/kubernetes/community/blob/master/contributors/design-proposals/scheduling/predicates-ordering.md)
. The Kubernetes scheduler, a component of the control plane, uses predicates to determine which nodes are eligible to host a Pending pod. For efficiency, the scheduler evaluates predicates in a specific order, saving more complex decisions for the end. If the scheduler cannot find any eligible nodes after checking these predicates, the pod will remain Pending until a suitable node becomes available.


**Scenario**
1, Node-based scheduling constraints, including node affinity, readiness and taints, labels
2, Pods' requested resources exceeding allocatable capacity
3, PersistentVolume-related issues
4, Pod affinity or anti-affinity rules
5, Rolling update deployment settings(maxSurge,maxUnavailable)

Node Affinity ensures that pods are hosted on particular nodes. Pod Affinity ensures two pods to be co-located in a single node


