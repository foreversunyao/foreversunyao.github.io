---
layout: post
title: "K8s DNS for Services and Pods"
date: 2020-09-11 09:25:06
description: Kubernetes dns, ndots, headless, NodeLocal DNSCache
tags:
 - k8s
---

**DNS-Based Service Discovery**
[refer](https://github.com/kubernetes/dns/blob/master/docs/specification.md)
[dns-pod-service](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/)
**How does DNS work in K8S**
[refer](https://medium.com/kubernetes-tutorials/kubernetes-dns-for-services-and-pods-664804211501)

**Tuning ndots**
[refer](https://pracucci.com/kubernetes-dns-resolution-ndots-options-and-why-it-may-affect-application-performances.html)
[refer2](https://ieevee.com/tech/2019/06/22/ndots.html)

**NodeLocal DNSCache**
[refer](https://kubernetes.io/docs/tasks/administer-cluster/nodelocaldns/)

**Debug**
```
container1: ping google.com
same network namespace: sudo nsenter -t xxx -n tcpdump -i eth0 udp port 53
```
