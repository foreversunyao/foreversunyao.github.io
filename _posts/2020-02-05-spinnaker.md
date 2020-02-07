---
layout: post
title: "Spinnaker"
date: 2020-02-05 10:25:06
description: Spinnaker, deployment
tags:
 - cloud
---

**What is Spinnaker**
Spinnaker is an open source, multi-cloud continuous delivery platform for releasing software changes with high velocity and confidence.

- multi-cloud
Deploy across multiple cloud providers including AWS EC2, Kubernetes, Google Compute Engine, Google Kubernetes Engine, Google App Engine, Microsoft Azure, Openstack, Cloud Foundry, and Oracle Cloud Infrastructure, with DC/OS coming soon.
- Automated Releases
Create deployment pipelines that run integration and system tests, spin up and down server groups, and monitor your rollouts. Trigger pipelines via git events, Jenkins, Travis CI, Docker, CRON, or other Spinnaker pipelines.
- Built-in Deployment Best Practices 
Create and deploy immutable images for faster rollouts, easier rollbacks, and the elimination of hard to debug configuration drift issues. Leverage an immutable infrastructure in the cloud with built-in deployment strategies such as red/black and canary deployments.

**Concepts**
![img]({{ '/assets/images/devops/spinnaker.png ' | relative_url }}){: .center-image }*(°0°)*
- application management
Applications:
An application in Spinnaker is a collection of clusters, which in turn are collections of server groups. The application also includes firewalls and load balancers.
An application represents the service which you are going to deploy using Spinnaker, all configuration for that service, and all the infrastructure on which it will run.

cluster:
You can define Clusters, which are logical groupings of Server Groups in Spinnaker.
Note: cluster, here, does not map to a Kubernetes cluster. It’s merely a collection of Server Groups, irrespective of any Kubernetes clusters that might be included in your underlying architecture.

server group:
The base resource, the Server Group, identifies the deployable artifact (VM image, Docker image, source location) and basic configuration settings such as number of instances, autoscaling policies, metadata, etc. This resource is optionally associated with a Load Balancer and a Firewall. When deployed, a Server Group is a collection of instances of the running software (VM instances, Kubernetes pods).

- application deployment
[pipeline](https://www.spinnaker.io/concepts/#pipeline)
![img]({{ '/assets/images/devops/spinnaker_pipeline.png ' | relative_url }}){: .center-image }*(°0°)*
The pipeline is the key deployment management construct in Spinnaker. It consists of a sequence of actions, known as stages. You can pass parameters from stage to stage along the pipeline.
A Stage in Spinnaker is an atomic building block for a pipeline, describing an action that the pipeline will perform. 

- Deployment strategies
Spinnaker supports the red/black (a.k.a. blue/green) strategy, with rolling red/black and canary strategies in active development.
Canary is a deployment process in which a change is partially rolled out, then evaluated against the current deployment (baseline) to ensure that the new deployment is operating at least as well as the old. This evaluation is done using key metrics that are chosen when the canary is configured.
![img]({{ '/assets/images/devops/spinnaker_strategies.png ' | relative_url }}){: .center-image }*(°0°)*


**Demo**
[workflow](https://aws.amazon.com/blogs/opensource/deployment-pipeline-spinnaker-kubernetes/)
[setup](https://opnfv-clover.readthedocs.io/en/latest/release/configguide/spinnaker_config_guide.html#bake-manifest-stage)
