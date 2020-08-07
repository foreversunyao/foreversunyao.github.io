---
layout: post
title: "K8s necessary images"
date: 2019-09-10 23:25:06
description: Kubernetes cluster necessary images
tags:
 - k8s
---

**images**
- lb
  metallb/speaker:v0.7.3
  metallb/controller:v0.7.3
  traefik:1.7
- monitor
  weaveworks/scope:1.11.2
  prom/prometheus:v2.9.2
  metrics-server-amd64:v0.3.2
  coreos/kube-state-metrics:v1.5.0
- network
  calico/node:v3.6.1
  calico/cni:v3.6.1
  coreos/flannel:v0.9.1
  pause:3.1 : The 'pause' container is a container which holds the network namespace for the pod. Kubernetes creates pause containers to acquire the respective pod’s IP address and set up the network namespace for all other containers that join that pod.
- k8s
  kube-scheduler:v1.14.0
  kube-controller-manager:v1.14.0
  kube-apiserver:v1.14.0
  kube-proxy:v1.14.0
  coredns:1.3.1
  etcd:3.3.10
- dashboard
  kubernetes-dashboard-amd64:v1.10.0
- other
  jaegertracing/jaeger-collector:1.13.1
  jaegertracing/jaeger-query:1.13.1
  cluster-proportional-autoscaler-amd64:1.4.0
  alpine3-base:latest
  addon-resizer:1.8.4
