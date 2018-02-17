---
layout: post
title: Consul
date: 2016-11-30 09:25:06
description: Distributed, highly available tool for service discovery, configuration, and orchestration from hashicorp.
tags: 
 - devops
---

**Consul**
Consul has multiple components, but as a whole, it is a tool for discovering and configuring services in your infrastructure. 
Key features:
Service Discovery:Consul makes it simple for services to register themselves and to discover other services via a DNS or HTTP interface. Register external services such as SaaS providers as well.
Failure Detection:Pairing service discovery with health checking prevents routing requests to unhealthy hosts and enables services to easily provide circuit breakers.
Multi Datacenter:Consul scales to multiple datacenters out of the box with no complicated configuration. Look up services in other datacenters, or keep the request local.
KV Storage:Flexible key/value store for dynamic configuration, feature flagging, coordination, leader election and more. Long poll for near-instant notification of configuration changes.

![img]({{ '/assets/images/devops/consul_arch.png' | relative_url }}){: .center-image }*(°0°)*

**Configuration**

**Monitor**
[grafana](11)

**CommandsandTools**
