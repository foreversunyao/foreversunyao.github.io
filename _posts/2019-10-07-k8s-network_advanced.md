---
layout: post
title: "K8s network Advanced"
date: 2019-10-07 14:25:06
description: canal, flannel, calico ..
tags:
 - k8s
---

**Container network**
[refer](http://events17.linuxfoundation.org/sites/events/files/slides/Container%20Networking%20Deep%20Dive.pdf)
[book](https://www.li9.com/wp-content/uploads/2018/07/Container-Networking-Docker-Kubernetes-180701.pdf)

**K8s network**
[refer](https://info.rancher.com/hubfs/eBooks,%20reports,%20and%20whitepapers/Diving%20Deep%20Into%20Kubernetes%20Networking.pdf)

**CNI and routing**
Kubernetes manages networking through CNI’s on top of docker and just attaches devices to docker. 
It’s also important to mention that k8s does not use docker0, which is docker’
default bridge, but creates its own bridge named cbr0, which was chosen to
differentiate from the docker0 bridge.
Kubernetes manages that by setting up the network itself on the pause container, which you will find for every pod you create. All other pods attach to the network of the pause container which itself does nothing but provide the network. Therefore, it is also possible for one container to talk to a service in a different container, which is in the same definition of the same pod, via localhost.

[advanced-k8s-network](https://neuvector.com/network-security/advanced-kubernetes-networking/)


**flannel**
1. features
- each node has a process called flannel, flanneld is responsible for subnet on that node and store them in etcd.
- 3 mode: UDP, VXLAN and host-gateway.
2. VXLAN mode, it will create flannel1 eth, between docker0 and eth0. data packing/unpacking and transfering is done by kernel
```
pod1 eth0->docker0->flannel.1->node1 eth0->node2 eth0->flannel.1->docker0->pod2 eth0
```
3. flanneld watch flannel0 eth and package its data, then transfer it to destination node flanneld according to its own route table 
[network](https://blog.laputa.io/kubernetes-flannel-networking-6a1cb1f8ec7c)
[flannel vs docker bridge](https://www.edureka.co/blog/kubernetes-networking/)
[flannel subnet](https://blog.laputa.io/kubernetes-flannel-networking-6a1cb1f8ec7c)

**calico**
1. features
- layer 3 virtual network
- do NOT use docker0 bridge
- do NOT need add wrapper to data package, no need NAT and port mapping
- use vRouter(on each node) to exchange data by BGP
- each pod has its own ip
- for large cluster, use BGP route reflector
- provide ACLs through iptables
2. network mode
- ipip
```

```
- BGP
```
pod 1 cali0->caliXXXX->node1 eth0->node2 eth0->caliXXXX->pod2 cali0
```
3. components
- Felix
- etcd
- BGP client
- BGP Route Reflector
- BIRD, share router info between peers
**canal**
Canal is a combination of Flannel and Calico, its benefits are also at the intersection of these two technologies. The networking layer is the simple overlay provided by Flannel that works across many different deployment environments without much additional configuration. The network policy capabilities layered on top supplement the base network with Calico’s powerful networking rule evaluation to provide additional security and control.
