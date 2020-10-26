---
layout: post
title: "K8s resource limits"
date: 2020-10-13 02:25:06
description: cpu time, mem
tags:
 - k8s
---

- cpu time
```
resources:
  requests:
    memory: 50Mi
    cpu: 50m
  limits:
    memory: 100Mi
    cpu: 100m
```
The unit suffix m stands for “thousandth of a core,” so this resources object specifies that the container process needs 50/1000 of a core (5%) and is allowed to use at most 100/1000 of a core (10%). Likewise 2000m would be two full cores, which can also be specified as 2 or 2.0.
[refer](https://medium.com/@betz.mark/understanding-resource-limits-in-kubernetes-cpu-time-9eff74d3161b)

- memory
[refer](https://medium.com/@betz.mark/understanding-resource-limits-in-kubernetes-memory-6b41e9a955f9)
