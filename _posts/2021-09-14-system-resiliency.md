---
layout: post
title: "Resiliency"
date: 2021-9-14 10:25:06
description: Quotas, Graceful Degradation, Timeouts, Exponential back-offs, Circuit breakers, Self healing system, Continuous Deployment and integration.
tags:
 - system
---
[refer](https://linkedin.github.io/school-of-sre/level102/system_design/resiliency/)

**Resiliency system**
Resilient architectures leverage system design patterns such as graceful degradation, quotas, timeouts and circuit breakers.

**Quotas**
 It is important to have something in place that will prevent one consumer or client from overwhelming such a system. Quotas are one way to do this - we simply assign a specific quota for each component - by way of specifying requests per unit time. Anyone who breaches the quota is either warned or dropped, depending on the implementation. 
Quotas also help us prevent cascading failures.

**Graceful Degradation**
Gracefully degrading is always better compared to total failures.
If system is not normal, Some functions can be done by customer input instead of providing suggestions list.

**Timeouts**
When calling such a resource from our application, it is important to always have a reasonable timeout. It just might be that a specific request falls in the high tail latency category.

**Exponential back-offs**
When a service endpoint fails, retries are one way to see if it was a momentary failure. However, if the retry is also going to fail, there is no point in endlessly retrying.


**Circuit breakers**
Circuit breakers can help failures from percolating the entire system. avoid retry storms.

**Self healing systems**
A traditionally load-balanced application with multiple instances might fail when more than a threshold of instances stop responding to requests - either because they are down, or suddenly there is a huge influx of requests, resulting in degraded performance. A self-healing system adds more instances in this scenario to replace the failed instances. Auto-scaling like this can also help when there is a sudden spike in query.

**Continuous Deployment and Integration**
There should also be a way for us to replay production traffic in the staging environment to test changes to production thoroughly.
