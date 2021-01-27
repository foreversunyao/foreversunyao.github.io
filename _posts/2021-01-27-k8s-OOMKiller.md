---
layout: post
title: "K8s OOMkiller"
date: 2019-01-27 14:25:06
description: k8s, OOMKiller, oom_score, container_memory_usage_bytes, container_memory_working_set_bytes
tags:
 - k8s
---
[OOMKiller](https://medium.com/faun/how-much-is-too-much-the-linux-oomkiller-and-used-memory-d32186f29c9d)

OOMKiller is watching container_memory_working_set_bytes, when it hits the limit, it will be killed

**How does OOMKilled work**
Kernal process called OOMKiller, continuously monitors the node memory to determine memory exhaustion. If OOM Killer detects such exhaustion, will choose to kill the best process(es). The best processes are chosen by keeping the following in mind.
- kill least number of processes to minimize the damage in terms of stability & importance of the system
- killing those processes should fetch maximum freed memory for the node
To facilitate this, the kernel maintains oom_score for each process. The higher the value of oom_score the bigger the chances of that process getting killed by OOM Killer. The kernel also provides flexibility for the user process to adjust oom_score using oom_score_adj value.

QoS and oom_score_adj
Guaranteed 998
BestEffort 1000
Burstable min(max(2, 1000-(1000*memoryRequestBytes)/ machineMemoryCapacityBytes),999)

```
kubectl get pod pod1 -o jsonpath='{.status.qosClass}'
```

**Kubernetes Requests and Limits**
Requests and limits are applied to the container specification as part of a deployment. As of Kubernetes 1.10 two resources types can have requests and limits set; CPU and Memory. CPU is specified as fractions of a CPU or core (down to 1/1000th) and memory is specified in bytes.
A request is a bid for the minimum amount of that resource your container will need. A request doesn’t say how much of a resource you will be using, just how much you will need. You are telling the scheduler just how many resources your container needs to do its job. Requests are used for scheduling by the Kubernetes scheduler. For CPU requests they are also used to configure how the containers are scheduled by the Linux kernel. More on that in another post.
A limit is the very maximum amount of that resource your container will ever use. Limits must be greater than or equal to requests. If you set only limits, the request will be the same as the limit.

```
container_cpu_user_seconds_total — The total amount of “user” time (i.e. time spent not in the kernel)
container_cpu_system_seconds_total — The total amount of “system” time (i.e. time spent in the kernel)
container_cpu_usage_seconds_total — The sum of the above.

container_memory_cache -- Number of bytes of page cache memory.
container_memory_rss -- Size of RSS in bytes.
container_memory_swap -- Container swap usage in bytes.
container_memory_usage_bytes -- Current memory usage in bytes,       
                                including all memory regardless of
                                when it was accessed.
container_memory_max_usage_bytes -- Maximum memory usage recorded 
                                    in bytes.
container_memory_working_set_bytes -- Current working set in bytes.
container_memory_failcnt -- Number of memory usage hits limits.
container_memory_failures_total -- Cumulative count of memory 
                                   allocation failures.
```
[refer](https://blog.freshtracks.io/a-deep-dive-into-kubernetes-metrics-part-3-container-resource-metrics-361c5ee46e66)
