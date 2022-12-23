---
layout: post
title: "K8s nat iptables"
date: 2022-09-06 02:25:06
description: service, nodeport, nat, iptables, kube-proxy
tags:
 - k8s
---

- kube-proxy is responsible for implementing a form of virtual IP for Services of type other than ExternalName.kube-proxy is one of the main implementers of the service discovery and load balancing in the cluster.

- kube-proxy maintains the clusterIP -> PodIP translation rules according to control-plane info

- kube-proxy modifies the iptables with NAT config to route traffic on NodePorts to specific target by "service"
```
KUBE-MARK-MASQ             tcp             --   0.0.0.0/0    0.0.0.0/0    /*  services/ingress:web  */  tcp  dpt:443
KUBE-SVC-TX  tcp             --   0.0.0.0/0    0.0.0.0/0    /*  services/ingress:web  */  tcp  dpt:443
KUBE-SVC-xxx  tcp            --   0.0.0.0/0    xx.xx.xx.xx   /*  services/ingress:web        cluster  IP          */     tcp   dpt:8080
```
- commands

```
sudo iptables -t nat -L PREROUTING | column -t
sudo iptables -t nat -L KUBE-SERVICES -n  | column -t
sudo iptables -t nat -L KUBE-NODEPORTS -n  | column -t
sudo ip netns exec
```
[refer1](https://www.tkng.io/services/clusterip/dataplane/iptables/)
[refer2](https://ronaknathani.com/blog/2020/07/kubernetes-nodeport-and-iptables-rules/)
