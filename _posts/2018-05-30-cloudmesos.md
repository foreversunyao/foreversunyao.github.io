---
layout: post
title: "Mesos"
date: 2018-05-30 20:50:06
description: Apache Mesos,Marathon
tags: 
 - cloud
---

**Apache Mesos**

Apache Mesos is an open source cluster manager developed at UC Berkeley. It provides resource isolation and sharing across distributed applications. 

Mesos consists of a master daemon that manages slave daemons running on each cluster node. Mesos frameworks are applications that run on Mesos and run tasks on these slaves. Slaves are either physical or virtual machines, typically from the same provider.

Mesos uses a two-level scheduling mechanism where resource offers are made to frameworks. The Mesos master node decides how many resources to offer each framework, while each framework determines the resources it accepts and what application to execute on those resources.

**Mesos Architecture**

![img]({{ '/assets/images/devops/mesos_1.png' | relative_url }}){: .center-image }*(°0°)*

![img]({{ '/assets/images/devops/mesos_3.png' | relative_url }}){: .center-image }*(°0°)*

**Mesos Component and Process**

 - Master daemon: runs on a master node and manages slave daemons
 - Slave daemon: runs on a master node and runs tasks that belong to frameworks
 - Framework: also known as a Mesos application, is composed of a scheduler, which registers with the master to receive resource offers, and one or more executors, which launches tasks on slaves. Examples of Mesos frameworks include Marathon, Chronos, and Hadoop
 - Offer: a list of a slave node's available CPU and memory resources. All slave nodes send offers to the master, and the master provides offers to registered frameworks
 - Task: a unit of work that is scheduled by a framework, and is executed on a slave node. A task can be anything from a bash command or script, to an SQL query, to a Hadoop job
 - Apache ZooKeeper: software that is used to coordinate the master nodes

![img]({{ '/assets/images/devops/mesos_2.png' | relative_url }}){: .center-image }*(°0°)*


[refer](https://docs.mesosphere.com/1.8/overview/components/)

**Mesos and Marathon**
Marathon is a framework for Mesos that is designed to launch long-running applications, and, in Mesosphere, serves as a replacement for a traditional init system.

![img]({{ '/assets/images/devops/mesosui1.png' | relative_url }}){: .center-image }*(°0°)*

![img]({{ '/assets/images/devops/mesosui2.png' | relative_url }}){: .center-image }*(°0°)*

![img]({{ '/assets/images/devops/marathon1.png' | relative_url }}){: .center-image }*(°0°)*

**Mesos Command**
[mesos endpoints](http://mesos.apache.org/documentation/latest/endpoints/)
 - create app : curl -X POST http://marathon:8080/v2/apps -d @nginx.json -H "Content-type: application/json"
