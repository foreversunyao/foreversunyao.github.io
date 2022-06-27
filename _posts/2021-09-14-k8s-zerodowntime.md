---
layout: post
title: "K8s zero downtime deployment"
date: 2022-04-14 23:25:06
description: graceful shutdown and zero downtime
tags:
 - k8s
---

# when a pod is created
1. kubelet -> call CRI for containers
        -> call CNI for cluster network and IP addresses
        -> call CSI for mounting volumes
2. the kubelet to collect all the details of the Pod such as the IP address and report them back to the control plane.

- docker creates virtual ethernet pairs and attaches it to a bridge
- AWS-CNI connects Pods directly to the rest of VPC



# graceful shutdown and zero downtime deployment
- two parallel flows when a pod is being deleted:
```
1. apiserver->endpoint controller->apiserver->kube-proxy/Ingress/Coredns -> iptables
2. apiserver->kubelet->prestophook->SIGTERM->gracefulshutdown->SIGKILL->apiserver
```
- Pod's IP address is still serving requests till it's removed from iptables
- preStop hook should be good enough to solve pod is terminated before iptables change , the down side might be the cost of resource for non-serving pods(endpoints removed but pod still running) if we set  preStop to wait too long
- terminationGracePeriodSeconds  is 30s by default, need to adjust if we want to make clean close for long-running tasks(call third party api or job)
```
        lifecycle:
          preStop:
            exec:


[refer](https://learnk8s.io/graceful-shutdown)
