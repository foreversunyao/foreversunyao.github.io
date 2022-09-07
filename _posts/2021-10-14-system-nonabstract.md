---
layout: post
title: "Non abstract large system design"
date: 2021-10-14 10:25:06
description: NALSD, capacity planning, component isolation, graceful system degradation, SLO/SLI, Scale cube and Availibility cube
tags:
 - system
---

**Application requirements**
1, availability of your product or service and this measurable should be owned by the technology team.
2, Start from One machine for entire application
3, calculation for resources
4, Design process
```
1, is it possible ? 
2, can we do better ? faster,smaller,efficient
3, is it feasible ? scale the design, given contraints on money, hw
4, is it resilient ? component fail, network fail, datacenter fail
5, can we do better again ?
```
**SLIs and SLOs**
[SLO](https://github.com/slok/sloth)
- service level indicator, a carefully defined quantitative measure of some aspect of the level of service that is provided.
like response time for loading the feed

- service level objective, a target value or range of values for a service level that is measured by an SLI. SLO is a way for us to anchor ourselves to an optimal user experience by defining SLI boundaries.
like SLO can be that at least 99% of the users should see their feed within 1 second.
like be able to server 50k concurrent users and a million total users.

**Clock Time is not the best measure**
Reasons:
```
1, Units of time are not equal in terms of business impact – a disruption during the busiest part of the day would be worse than an issue during a slow period.  This is intrinsically known as many companies schedule maintenance windows for late at night or early in the morning, periods where the impact of disruption is smaller.
2, The business communicates in business terms (revenue, cost, margin, return on investment) and these terms are measured in dollars, not clock time.
3, Using the uptime figure from a server or other infrastructure component as an availability measure is inaccurate because it does not capture software bugs or other issues rendering your service inoperative despite the server uptime status.
```
What are the goals of your business?  What is your value proposition?  Choose metrics that comprehensively measure the availability of your product or service.

**Estimating resource requirements**
- hw store data
like 100 bytes/1 person, and 10GB/1 million
- mem store data
like cache for 100 bytes uerid/person
- resources per request
15 bytes per user to call api --> we have 1000Mbps network link, so can server 80 users before we saturate network link 
- cpu count
cpu usage per request, concurrent

[refer](https://sre.google/workbook/non-abstract-design/)


**Scale cube**
[refer](https://akfpartners.com/growth-blog/scale-cube)
The Scale Cube (sometimes known as the “AKF Scale Cube” or “AKF Cube”) is comprised of 3 axes: 
    • X-Axis: Horizontal Duplication and Cloning of services and data
    • Y-Axis: Functional Decomposition and Segmentation - Microservices (or micro-services)
    • Z-Axis: Service and Data Partitioning along Customer Boundaries - Shards/Pods
![img]({{ '/assets/images/cloud/scale-cube-infographic.jpeg' | relative_url }}){: .center-image }*(°0°)*

**Availability cube**
[refer](https://akfpartners.com/growth-blog/akf-availability-cube)
1-((1 - Availibility of node1) * (1 - Availibility of node2))
![img]({{ '/assets/images/cloud/Availability_Cube_draft.jpeg' | relative_url }}){: .center-image }*(°0°)*
