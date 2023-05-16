---
layout: post
title: "PagerDuty - Service-Based"
date: 2023-05-10 12:25:06
description: pagerduty, service-based, team-based
tags: 
 - sre
---
[refer](https://www.pagerduty.com/blog/service-based-approach-incident-response/)
what the business really cares about is being able to do business—and anything that impacts that needs to be quickly addressed. 

- service-based benefit
For example, let’s say you’re on the Site Reliability Engineering team and receive a notification about a service being down. But another responder on the database team also got the same notification. Because you can now look at associated incidents across multiple services, you can see that it’s a database issue, so you can stop working on the issue since you know the database team will take care of it.
```
Visibility needed to understand the health of services and improve processes
Insights to see what’s trending to identify hotspots
Ability to easily and quickly see which team supports what services vs. having to first go through multiple teams and understanding those layers before getting to the service
```

- team-based drawbacks
would not be able to :
```
Assess the business impact of incidents in real time
Analyze the impact your services are having on the reliability or stability of your application
Accurately assess the blast radius of issues, which is important since they typically span across multiple services
Quickly determine which business stakeholders need to be notified during major incidents
```

