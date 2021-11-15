---
layout: post
title: "Non abstract large system design"
date: 2021-10-14 10:25:06
description: NALSD, capacity planning, component isolation, graceful system degradation
tags:
 - systemdesign
---
**Application requirements**

**SLIs and SLOs**
- service level indicator, a carefully defined quantitative measure of some aspect of the level of service that is provided.
like response time for loading the feed

- service level objective, a target value or range of values for a service level that is measured by an SLI. SLO is a way for us to anchor ourselves to an optimal user experience by defining SLI boundaries.
like SLO can be that at least 99% of the users should see their feed within 1 second.
like be able to server 50k concurrent users and a million total users.

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
