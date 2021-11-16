---
layout: post
title: "fault isolation"
date: 2020-11-15 10:25:06
description: fault isolation
tags:
 - systemdesign
---

**fault isolation**
A “swim lane” or fault isolation zone is a failure domain. A failure domain is a group of services within a boundary such that any failure within that boundary is contained within the boundary and the failure does not propagate or affect services outside of the said boundary. 

**benefit**
1, Fault Detection: Given a granular enough approach, the component of availability associated with the time to identify the failure is significantly reduced. This is because all effort to find the root cause or failed component is isolated to the section of the product or platform associated with the failure domain
2, Fault Isolation: As stated previously, the failure does not propagate or cause a deterioration of other services within the platform. only a portion of users or a portion of the functionality of the product is affected.

**how to design**
1, User-initiated synchronous calls between failure domains are absolutely forbidden in this type of architecture as any user-initiated synchronous call between fault isolation zones, even with an appropriate timeout and detection mechanisms, is very likely to cause a cascading series of failures across other domains. 
2, if have to use synchronous call, build a copy of the service within the swim lane.
3, It is acceptable, but not advisable, to have asynchronous calls between domains and to have non-user initiated synchronous calls between domains (as in the case of a batch job collecting data for the purposes of reporting in another failure domain).it is very important to include failure detection and timeouts.

![img]({{ '/assets/images/cloud/fault_isolation_design.png' | relative_url }}){: .center-image }*(°0°)*


**details**
[refer](https://akfpartners.com/growth-blog/fault-isolation-swim-lane)
