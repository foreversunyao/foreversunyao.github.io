---
layout: post
title: "Docker Details"
date: 2017-10-05 17:50:06
description: Docker Details
tags: 
 - devops
---

**Docker Architecture**

![img]({{ '/assets/images/devops/Docker-architecture.jpg' | relative_url }}){: .center-image }*(°0°)*

The Docker daemon (dockerd) listens for Docker API requests and manages Docker objects such as images, containers, networks, and volumes. A daemon can also communicate with other daemons to manage Docker services.
The Docker client (docker) is the primary way that many Docker users interact with Docker.
A Docker registry stores Docker images.
An image is a read-only template with instructions for creating a Docker container.
A container is a runnable instance of an image.
Docker Engine combines the namespaces, control groups, and UnionFS into a wrapper called a container format. The default container format is libcontainer.

**Docker vs VM**

Containers Are not Virtual Machine
Docker is like very lightweight wrappers around a single Unix process. And Docker OS denpends on OS intalled on the hardware. A container is a self-contained execution environment that shares the kernel of the host system and which is (optionally) isolated from other containers in the system. Virtual Machines are by design a stand-in for real hardware that you might throw in a rack and leave there for a few years.

**Docker in Details**

 - Control Group:

Control groups (cgroups), allow you to allocate resources such as CPU time, system memory, network bandwidth, or combinations of these resources for a service, so that an activity per service instance can be ran and constrained by cgroups on the system.
Resource limiting – groups can be set to not exceed a configured memory limit, which also includes the file system cache
Prioritization – some groups may get a larger share of CPU utilization or disk I/O throughput
Accounting – measures a group's resource usage, which may be used, for example, for billing purposes
Control – freezing groups of processes, their checkpointing and restarting

 - Namespace:

PID Namespace: Anytime a program starts, a unique ID number is assigned to the namespace that is different than the host system. Each container has its own set of PID namespaces for its processes
MNT Namespace: Each container is provided its own namespace for mount directory paths.
NET Namespace: Each container is provided its own view of the network stack avoiding privileged access to the sockets or interfaces of another container.
UTS Namespace: This provides isolation between the system identifiers; the hostname and the NIS domain name.
IPC Namespace: The inter-process communication (IPC) namespace creates a grouping where containers can only see and communicate with other processes in the same IPC namespace.

**Docker Storage** 

![img]({{ '/assets/images/devops/aufs.png' | relative_url }}){: .center-image }*(°0°)*

AuFS started as an implementation of UnionFS Union File System. An union filesystem takes an existing filesystem and transparently overlays it on a newer filesystem. It allows files and directories of separate filesystem to co-exist under a single roof. AuFS can merge several directories and provide a single merged view of it. Not in mainline kernel CoW works at file level Before writing, file has to be copied at upper most layer Overlayfs is also like AUFS, but it only have two layers(lower and upper).

![img]({{ '/assets/images/devops/Device-Mapper.jpg' | relative_url }}){: .center-image }*(°0°)*


The Device Mapper provides the foundation for a number of higher-level technologies. In addition to LVM, Device-Mapper multipath and the dmraid command use the Device Mapper. The application interface to the Device Mapper is the ioctl system call. The user interface is the dmsetup command.

Volume Data volumes provide several useful features for persistent or shared data: Volumes are initialized when a container is created. If the container’s parent image contains data at the specified mount point, that existing data is copied into the new volume upon volume initialization. (Note that this does not apply when mounting a host directory.) Data volumes can be shared and reused among containers. Changes to a data volume are made directly. Changes to a data volume will not be included when you update an image. Data volumes persist even if the container itself is deleted.

**Docker Network**

![img]({{ '/assets/images/devops/docker-network.png' | relative_url }}){: .center-image }*(°0°)*

Host With the host driver, a container uses the networking stack of the host. There is no namespace separation, and all interfaces on the host can be used directly by the container.
Bridge The bridge driver creates a Linux bridge on the host that is managed by Docker. By default containers on a bridge can communicate with each other. External access to containers can also be configured through the bridge driver.
Overlay	The overlay driver creates an overlay network that supports multi-host networks out of the box. It uses a combination of local Linux bridges and VXLAN to overlay container-to-container communications over physical network infrastructure.

**Docker Security**

By default, many containers use UID 0 to launch processes. Because the container is contained, this seems safe , but in reality it isn't. Because everything is running on the same kernel, many types of security vulnerabilities or simple misconfiguration can give the containers' root user unauthorized access to the host's system resources,files,and proceses.

**dockerd,containerd,runc**
![img]({{ '/assets/images/devops/container_lifecycle.png' | relative_url }}){: .center-image }*(°0°)*

**containerd**
![img]({{ '/assets/images/devops/containerd.png' | relative_url }}){: .center-image }*(°0°)*

**k8s-containerd**
![img]({{ '/assets/images/devops/container-k8s.png' | relative_url }}){: .center-image }*(°0°)*

**rkt vs docker**
[rkt](https://joejulian.name/post/kubernetes-container-engine-comparison/)
[rkt vs docker](https://coreos.com/rkt/docs/latest/rkt-vs-other-projects.html)
  - daemon
  - root
**how to make image smaller**
- alpine
alpine linux use musl , on the other hand, most linux distributions use glibc.
busybox

[refer](https://hackernoon.com/tips-to-reduce-docker-image-sizes-876095da3b34)
