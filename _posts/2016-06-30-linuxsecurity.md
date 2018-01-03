---
layout: post
title: "Linux Security"
date: 2016-06-30 17:25:06
description: Linux Security
tags: 
 - linux
---

**Security Auditd**

![img]({{ '/assets/images/linux/Auditd.png' | relative_url }}){: .center-image }*(°0°)*

The auditd subsystem is an access monitoring and accounting for Linux developed and maintained by RedHat. It was designed to integrate pretty tightly with the kernel and watch for interesting system calls. Additionally, likely because of this level of integration and detailed logging, it is used as the logger for SELinux. 

First let me explain the colors. Light blue are the things that create the events, purple is the reporting tools, red is the controller, gray is the logs, and green is the real-time components.

Audit events can be created in two ways. There are applications that send events any time something specific happens. For example, if you log in to sshd, it will send a series of events as the log in proceeds. It is considered a trusted application and it always tries to send events. If the audit system is not enabled, the event is discarded. Otherwise the kernel accepts the event, time stamps it, adds sender information to the event, and queues it for delivery to the audit daemon, auditd. The only job that the audit daemon has is to reliably dequeue and write events to the log and the event dispatcher, audispd.

The other way that events are created is by the kernel observing system activity that matches a rule loaded by auditctl. The kernel is the thing that creates most events...assuming you loaded rules. It uses a first matching rule system to decide if a syscall is of any interest.

**OSsec**

![img]({{ '/assets/images/linux/ossec-desc.png' | relative_url }}){: .center-image }*(°0°)*

OSSEC is an Open Source Host-based Intrusion Detection System. It performs log analysis, integrity checking, Windows registry monitoring, rootkit detection, real-time alerting and active response. 
