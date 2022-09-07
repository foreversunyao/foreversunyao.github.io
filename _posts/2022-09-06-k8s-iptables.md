---
layout: post
title: "K8s nat iptables"
date: 2022-09-06 02:25:06
description: service, nodeport, nat, iptables, kube-proxy
tags:
 - k8s
---

- traffic flow from outside
dns -> network load balancer(vpc, az, subnet, public eip) -> target instance(traefik service is running with nodePort 30443) --> traefik pods(targetport)

- kube-proxy binds and listens on all NodePorts to ensure these ports stay reserved on all nodes in k8s
- kube-proxy modifies the iptables with NAT config to route traffic on NodePorts to specific target by "service"
```
KUBE-MARK-MASQ             tcp             --   0.0.0.0/0    0.0.0.0/0    /*  services/traefikingress:web  */  tcp  dpt:30443
KUBE-SVC-TX  tcp             --   0.0.0.0/0    0.0.0.0/0    /*  services/traefikingress:web  */  tcp  dpt:30443
KUBE-SVC-xxx  tcp            --   0.0.0.0/0    xx.xx.xx.xx   /*  services/traefikingress:web        cluster  IP          */     tcp   dpt:8080
```
- commands

```
sudo iptables -t nat -L PREROUTING | column -t
sudo iptables -t nat -L KUBE-SERVICES -n  | column -t
sudo iptables -t nat -L KUBE-NODEPORTS -n  | column -t
```

[refer](https://ronaknathani.com/blog/2020/07/kubernetes-nodeport-and-iptables-rules/)
