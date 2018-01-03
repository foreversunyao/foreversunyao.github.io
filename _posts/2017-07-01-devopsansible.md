---
layout: post
title: "Ansible and Automation"
date: 2017-07-01 20:50:06
description: Ansible and CMDB for Automation
tags: 
 - devops
---

**Ansible and CMDB**

![img]({{ '/assets/images/devops/Ansible.jpg' | relative_url }}){: .center-image }*(°0°)*

Inventories: Ansible inventories are lists of hosts (nodes) along with their IP addresses, servers, databases etc. which needs to be managed. Ansible then takes action via a transport – SSH for UNIX, Linux or Networking devices and WinRM for Windows system.

Plugins: Plugins allows to execute Ansible tasks as a job build step. Plugins are pieces of code that augment Ansible’s core functionality. 

Playbooks: Playbooks are simple files written in YAML format which describes the tasks to be executed by Ansible. Playbooks can declare configurations, but they can also orchestrate the steps of any manual ordered process, even if it contains jump statements. They can launch tasks synchronously or asynchronously. 

CMDB : It is a repository that acts as a data warehouse for IT installations. It holds data relating to a collection of IT assets (commonly referred to as configuration items (CI)), as well as to describe relationships between such assets.
