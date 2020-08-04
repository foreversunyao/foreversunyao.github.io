---
layout: post
title: "K8s network Advanced"
date: 2019-10-07 14:25:06
description: canal, flannel, calico ..
tags:
 - cloud
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
Flannel is one of the most straightforward network providers for Kubernetes.
It operates at Layer 3 and offloads the actual packet forwarding to a backend
such as VxLAN or IPSec. It assigns a large network to all hosts in the cluster
and then assigns a portion of that network to each host. Routing between
containers on a host happens via the usual channels, and Flannel handles
routing between hosts using one of its available options.
Flannel uses etcd to store the map of what network is assigned to which host.
The target can be an external deployment of etcd or the one that Kubernetes
itself uses.
Flannel does not provide an implementation of the NetworkPolicy resource. 
[network](https://blog.laputa.io/kubernetes-flannel-networking-6a1cb1f8ec7c)

**calico**
Calico operates at Layer 3 and assigns every workload a
routable IP address. It prefers to operate by using BGP without
an overlay network for the highest speed and efficiency, but in
scenarios where hosts cannot directly communicate with one
another, it can utilize an overlay solution such as VxLAN or IPin-IP.
Calico supports network policies for protecting workloads and
nodes from malicious activity or aberrant applications.
The Calico networking Pod contains a CNI container, a
container that runs an agent that tracks Pod deployments and
registers addresses and routes, and a daemon that announces
the IP and route information to the network via the Border
Gateway Protocol (BGP). The BGP daemons build a map of the
network that enables cross-host communication.
Calico requires a distributed and fault-tolerant key/value
datastore, and deployments often choose etcd to deliver this
component. Calico uses it to store metadata about routes,
virtual interfaces, and network policy objects.

**canal**
Canal is a combination of Flannel and Calico, its benefits are also at the intersection of these two technologies. The networking layer is the simple overlay provided by Flannel that works across many different deployment environments without much additional configuration. The network policy capabilities layered on top supplement the base network with Calico’s powerful networking rule evaluation to provide additional security and control.
