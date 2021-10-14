---
layout: post
title: "K8s debug scheduling"
date: 2021-10-13 23:25:06
description: debug kube pending pods and scheduling failures
tags:
 - k8s
---

[refer](https://www.datadoghq.com/blog/debug-kubernetes-pending-pods/#node-affinity-and-anti-affinity-rules)

**Node selection in kube-scheduler**
```
kube-scheduler selects a node for the pod in a 2-step operation:

Filtering
Scoring
The filtering step finds the set of Nodes where it's feasible to schedule the Pod. For example, the PodFitsResources filter checks whether a candidate Node has enough available resource to meet a Pod's specific resource requests. After this step, the node list contains any suitable Nodes; often, there will be more than one. If the list is empty, that Pod isn't (yet) schedulable.

In the scoring step, the scheduler ranks the remaining nodes to choose the most suitable Pod placement. The scheduler assigns a score to each Node that survived filtering, basing this score on the active scoring rules.

Finally, kube-scheduler assigns the Pod to the Node with the highest ranking. If there is more than one node with equal scores, kube-scheduler selects one of these at random.
```

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

**Scheduling policies**
1, configure predicates for filtering and priorities for scoring.
https://kubernetes.io/docs/reference/scheduling/policies/
2, configure Plugins that implement different scheduling stages, including: QueueSort, Filter, Score, Bind, Reserve, Permit, and others.
https://kubernetes.io/docs/reference/scheduling/config/#scheduling-plugins

