---
layout: post
title: "K8s security(WIP)"
date: 2019-10-26 01:10:06
description: authentication, authorization, pod security, network security and so on
tags:
 - cloud
---

[refer](https://kubernetes.io/docs/concepts/security/)

**k8s cluster**
- TLS for all API traffic & Ingress
- API authentication/authorization
- Controlling access to kubelet(it allows unauthenticate access its https endpoints)
- Controlling capabilites of a workload or user at runtime(resource quota and
  limit ranges/pod security policies(securityContext for pod)/preventing containers from loading unwanted kernel modules)
- Restricting network access
- Application secrets management
- Network policies
- etcd encryption
- enable audit
- rotate credentials

**container**
- security context for container
- capabilities for container
- SELinux for container
- image signing(Content Trust)

**code**
- Access over TLS only
- Limiting port ranges
- 3rd Party denpendency security
- Static code analysis
- Dynamic probing attacks


**OpenID Connect Identity with dex**
[dex](https://github.com/dexidp/dex/blob/master/Documentation/kubernetes.md)
