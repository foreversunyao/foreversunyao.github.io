---
layout: post
title: "K8s operator"
date: 2021-01-12 02:25:06
description: operator, k8s patterns, CRD lifecycle, operator-sdk, kind
tags:
 - k8s


operator = custom fields + control loop

**Why Operator**
[refer](https://www.cncf.io/blog/2022/06/15/kubernetes-operators-what-are-they-some-examples/)
Operators actually allow for automatic implementation of typical Day-1 tasks (installation, configuration, etc.) and Day-2 tasks (reconfiguration, upgrade, backup, failover, recovery, etc.), for a software running within the Kubernetes cluster, integrating natively with Kubernetes concepts and APIs.
for stateful applications which need preparation and post-provisioning steps


**What is Operator**
“An operator is a way of building an application and driving an application on top of Kubernetes, behind Kubernetes APIs.
In order to do these things, the Operator uses Custom Resources (CR) that define the desired configuration and state of a specific application through Custom Resource Definitions (CRD). The Operator’s role is to reconcile the actual state of the application with the state desired by the CRD using a control loop in which it can automatically scale, update, or restart the application

**Componenets**
An operator consists of two things:
One or more Kubernetes custom resource definitions, or CRDs. These describe to Kubernetes a new kind of resource, including what fields it should have. There may be multiple, for example etcd-cluster-operator has both EtcdCluster and EtcdPeer to encapsulate different concepts.
A running piece of software that reads the custom resources, and acts in response, usually a controller

**Pros**
- Kubernetes Operators allow developers to easily extend Kubernetes functionality for specific software [and] use cases
- Operators do this in a scalable, repeatable, standardized fashion
- Operators systematize human knowledge as code

**Cons**
- more code need to maintain


**personal demo**
[simple-k8s-operator](https://github.com/foreversunyao/simple-k8s-operator)
```
 tree -L 1
.
├── Dockerfile
├── Makefile  - all userful make targets(generate code, manifest, build and push docker image, install crds, deploying controller)
├── PROJECT   - metadata         
├── README.md
├── api       - Spec and status for CR
├── bin
├── config    - all yaml files
├── controllers  - reconcile logic
├── go.mod    - all basic dependencies 
├── go.sum
├── hack
└── main.go    - entry point of the project

5 directories, 7 files
```


**example**
[video](https://www.youtube.com/watch?v=9QR3sRp-6Xk)
[kubebuilder](https://kubebuilder.io/)
