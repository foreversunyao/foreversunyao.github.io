---
layout: post
title: "K8s security"
date: 2019-10-26 01:10:06
description: authentication, authorization, pod security, network security, csr  and so on
tags:
 - k8s
---

[refer](https://kubernetes.io/docs/concepts/security/)

API requests go through a security pipeline (authentication, authorization, and admission control)


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

**authentication**
Kubernetes uses client certificates, bearer tokens, an authenticating proxy, or HTTP basic auth to authenticate API requests through authentication plugins. As HTTP requests are made to the API server, plugins attempt to associate the following attributes with the request:
Username: a string which identifies the end user. Common values might be kube-admin or jane@example.com.
UID: a string which identifies the end user and attempts to be more consistent and unique than username.
Groups: a set of strings which associate users with a set of commonly grouped users.
Extra fields: a map of strings to list of strings which holds additional information authorizers may find useful.

**authorization**
Kubernetes authorizes API requests using the API server. It evaluates all of the request attributes against all policies and allows or denies the request. All parts of an API request must be allowed by some policy in order to proceed. This means that permissions are denied by default.
When multiple authorization modules are configured, each is checked in sequence. If any authorizer approves or denies a request, that decision is immediately returned and no other authorizer is consulted. If all modules have no opinion on the request, then the request is denied. A deny returns an HTTP status code 403.

Kubernetes reviews only the following API request attributes:
user - The user string provided during authentication.
group - The list of group names to which the authenticated user belongs.
extra - A map of arbitrary string keys to string values, provided by the authentication layer.
API - Indicates whether the request is for an API resource.
Request path - Path to miscellaneous non-resource endpoints like /api or /healthz.
API request verb - API verbs like get, list, create, update, patch, watch, delete, and deletecollection are used for resource requests. To determine the request verb for a resource API endpoint, see Determine the request verb.
HTTP request verb - Lowercased HTTP methods like get, post, put, and delete are used for non-resource requests.
Resource - The ID or name of the resource that is being accessed (for resource requests only) – For resource requests using get, update, patch, and delete verbs, you must provide the resource name.
Subresource - The subresource that is being accessed (for resource requests only).
Namespace - The namespace of the object that is being accessed (for namespaced resource requests only).
API group - The API Group being accessed (for resource requests only). An empty string designates the core API group.


**CSR**
[refer](https://github.com/JulienBalestra/kube-csr#issue)

1, kubelet generate pk/csr and send to api
2, api pending and approved and ask controller manager to issue certificate
3, api issued cert
4, kubelet fetch cert
