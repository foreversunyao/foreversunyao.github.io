---
layout: post
title: "K8s debug scheduling"
date: 2022-02-13 23:25:06
description: debug kube pending pods and scheduling failures
tags:
 - k8s
---

[refer](https://www.datadoghq.com/blog/debug-kubernetes-pending-pods/#node-affinity-and-anti-affinity-rules)
[refer2](https://kubernetes.io/docs/concepts/scheduling-eviction/_print/#percentage-of-nodes-to-score)

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

**Higher priority Pods are preempted before lower priority pods**
The scheduler tries to find nodes that can run a pending Pod. If no node is found, the scheduler tries to remove Pods with lower priority from an arbitrary node in order to make room for the pending pod. If a node with low priority Pods is not feasible to run the pending Pod, the scheduler may choose another node with higher priority Pods (compared to the Pods on the other node) for preemption. The victims must still have lower priority than the preemptor Pod.

When there are multiple nodes available for preemption, the scheduler tries to choose the node with a set of Pods with lowest priority. However, if such Pods have PodDisruptionBudget that would be violated if they are preempted then the scheduler may choose another node with higher priority Pods.

When multiple nodes exist for preemption and none of the above scenarios apply, the scheduler chooses a node with the lowest priority.

**Scheduler performance tuning**
[refer](https://kubernetes.io/docs/concepts/scheduling-eviction/_print/#percentage-of-nodes-to-score)
To improve scheduling performance, the kube-scheduler can stop looking for feasible nodes once it has found enough of them. In large clusters, this saves time compared to a naive approach that would consider every node.

You specify a threshold for how many nodes are enough, as a whole number percentage of all the nodes in your cluster. The kube-scheduler converts this into an integer number of nodes. During scheduling, if the kube-scheduler has identified enough feasible nodes to exceed the configured percentage, the kube-scheduler stops searching for more feasible nodes and moves on to the scoring phase.
