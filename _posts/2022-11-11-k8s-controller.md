---
layout: post
title: "K8s controller(Ongoing)"
date: 2022-11-11 14:25:06
description: kubernetes, controller, custom resources, operatiors, kubebuilder
tags:
 - k8s
---

**Controller**
1. a control loop to describe a never-ending loop that tries to bring a system’s current state into the desired state, state is stored in ETCD.
2. it tracks at least one kind of kubernetes resource and is responsible to bring the state of the existing resources to the desired state. it talks to API server for the current state and comparing it to desired ones

![img]({{ '/assets/images/cloud/k8s_controller.png' | relative_url }}){: .center-image }*(°0°)*

**API and objects**
- object
A Kubernetes object is a “record of intent” - once you create the object, the Kubernetes system will constantly work to ensure that object exists.
We can think about object as a representation of 'group + version + type' , like '/api+v1+Pod'
object spec and object status
```
basic:
- Pod
- Service
- Volume
- Namespace

controller objects:
- ReplicaSet
- Deployment
- StatefulSet
- Job
```
```
apiVersion: xx
kind: xxx
metadata:
  xxx
spec:
  xxx
```

- API
API group is specificed in a REST path and in the apiVersion field of a serialized object. /apis/$GROUP_NAME/$VERSION
```
kubectl api-versions
```


**Resource**
resource, is an endpoint in the Kubernetes API that stores a collection of API objects of a certain kind. 
/api/v1/pods resource -> a list of v1 pod objects
custom resource (CR), is an object that adds objects to the existing Kubernetes API or allows you to introduce your own API into a project or a cluster.
the state of a Kubernetes cluster is fully defined by the state of the resources it contains

**CRD**
Defining a CRD object creates a new custom resource with a name and schema that you specify. The Kubernetes API serves and handles the storage of your custom resource. This frees you from writing your own API server to handle the custom resource, but the generic nature of the implementation means you have less flexibility than with API server aggregation
```
- deploying a CRD into the cluster causes the Kubernetes API server to begin serving the specified custom resource,
- with a CRD in place, users gain access to a significant subset of Kubernetes API functionality, such as CRUD, RBAC, lifecycle hooks, and garbage collection.
```


**Operators**
An Operator is an application-specific controller that extends the Kubernetes API to create, configure and manage instances of complex STATEFUL applications on behalf of a Kubernetes user. 

Advantage of operators:
- handling updates from one version to another
- handling failure recovery if it’s needed, scaling the application up and down depending on use cases
- without Operators, many applications need intervention to deploy, scale, reconfigure, upgrade, or recover from faults

- if you just want to add a resource to your Kubernetes cluster, then consider using Custom Resource Definition. They require less coding and rebasing.
- If you want to build an Extension API server, consider using apiserver-builder like kubebuilder.

[operatorhub.io](https://operatorhub.io)

**kubebuilder**
Kubebuilder is a framework for building Kubernetes APIs using custom resource definitions (CRDs).
[kubebuilder](https://book.kubebuilder.io/architecture.html)

**operator-sdk**
The Operator SDK is a framework that uses the controller-runtime library to make writing operators easier by providing:

- High level APIs and abstractions to write the operational logic more intuitively
- Tools for scaffolding and code generation to bootstrap a new project fast
- Extensions to cover common Operator use cases


[refer](https://medium.com/@marom.itamar/kubernetes-controllers-custom-resources-and-operators-explained-8e92f46829f6)
[refer2](https://michalswi.medium.com/introduction-to-kubernetes-api-the-way-to-understand-the-concept-of-kubernetes-operators-ed667385caf4)

