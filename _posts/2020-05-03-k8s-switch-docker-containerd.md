---
layout: post
title: "K8s containerd"
date: 2021-05-03 00:25:06
description: Docker, containerd, dockershim
tags:
 - k8s
---
**background**
In Kubernetes v1.20, dockershim will be deprecated and eventually removed in next releases

The containerd CRI plugin is enabled by default and you can use containerd for Kubernetes while still allowing Docker to function.
[refer](https://kubernetes.io/blog/2020/12/02/dockershim-faq/)

**how to switch**
[refer1](https://kinvolk.io/docs/flatcar-container-linux/latest/container-runtimes/switching-from-docker-to-containerd-for-kubernetes/)

[refer2](https://kruyt.org/migrate-docker-containerd-kubernetes/)
