---
layout: post
title: "K8s implementation details, kubeadm"
date: 2021-05-29 00:25:06
description: design principles, constatns values and path, init workflow, kubeadm
tags:
 - k8s
---
[refer](https://kubernetes.io/docs/reference/setup-tools/kubeadm/implementation-details/)

**static pod**
Kubeadm writes static Pod manifest files for control plane components to /etc/kubernetes/manifests. The kubelet watches this directory for Pods to create on startup
```
/etc/kubernetes/manifests# ls
etcd.yaml  kube-apiserver.yaml  kube-controller-manager.yaml  kube-scheduler.yaml
```

**apiserver**
1. using --runtime-config= to test cluster for new change
