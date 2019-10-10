---
layout: post
title: "K8s service mesh"
date: 2019-10-09 00:25:06
description: service mesh, microservies
tags:
 - cloud
---

![img]({{ '/assets/images/cloud/service_mesh.png' | relative_url }}){: .center-image }*(°0°)*

**What is service mesh**
"IPC" for microservices ?

**What it works for**
I feel like it's for microservices, because of microservices we have more  communication work between services than before, if it's still in application layer, it would be hard to debug system and maintainance, and duplicate implement by different code. So service mesh is a new layer focusing on services communication(probably network functions).

**Functions of service mesh**
- Resiliency for inter-service communications: Circuit-breaking, retries and timeouts, fault injection, fault handling, load balancing and failover.
- Service Discovery: Discovery of service endpoints through a dedicated service registry.
- Routing: Primitive routing capabilities, but no routing logics related to the business functionality of the service.
- Observability: Metrics, monitoring, distributed logging, distributed tracing.
- Security: Transport level security (TLS) and key management.
- Access Control: Simple blacklist and whitelist based access control.
- Deployment: Native support for containers. Docker and Kubernetes.
- Interservice communication protocols: HTTP1.x, HTTP2, gRPC

**Some opensources**
- Istio
- Linkerd
[comparision](https://www.abhishek-tiwari.com/a-sidecar-for-your-service-mesh/)

**reference**
[refer](https://medium.com/microservices-in-practice/service-mesh-for-microservices-2953109a3c9a)
