---
layout: post
title: "Orchestration and choreography patterns"
date: 2023-10-15 10:25:06
description: orchestration, choreography 
tags:
 - system
---

[refer](https://docs.aws.amazon.com/prescriptive-guidance/latest/cloud-design-patterns/orchestration-choreography.html)

- Orchestration
**Pros**
Business logic and flow are easy to understand.
Business logic and flow are source-controlled.
End-to-end monitoring and reporting are simplified because the orchestrator is implemented by a single service; that is, Step Functions.
**Cons**
This pattern follows a request/response pattern. If a service is taking time to reply, the entire system is impacted.
Services are tightly coupled because they are dependent on a response from another service.
The orchestrator is a single point of failure. If it isn't carefully designed, you will end up with a monolith.
Updating the orchestrator or orchestrator logic might introduce downtime.

- Choreography
**Pros**
Components can be changed independently.
Components can be scaled independently.
This pattern enables more agile development than the orchestration pattern.
There is no single point of failure.
This pattern enables easier integration with external systems, compared with the orchestration pattern.
Events can be used for auditing and troubleshooting purposes because they reflect every change in the system.
**Cons**
It might be difficult to capture full business logic from the implementation because the flow isn't explicitly modelled.
End-to-end monitoring and reporting are more difficult to achieve compared with the orchestration pattern.
It's more difficult to implement timeouts, retries, and other resiliency patterns globally, compared with orchestration. This pattern has to be implemented on individual components.
