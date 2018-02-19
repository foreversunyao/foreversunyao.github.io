---
layout: post
title: "Monitor System(Ongoing)"
date: 2017-10-21 20:50:06
description: Zabbix,Influxdb,Prometheus,Grafana, Pull vs Push
tags: 
 - devops
---

**Push vs Pull**
![img]({{ '/assets/images/devops/monitor_push_pull.png' | relative_url }}){: .center-image }*(°0°)*

**Zabbix**
has push and pull mode
lots of templates and powerfull agent
Database performance maybe the bottleneck
good for network devices and physical servers

**Prometheus**
pull mode
similar levedb engine
good for container and services
has collector and alert systems
no cluster right now

**Influxdb**
push mode
only time series database, need others to support
TSM engine

**OpenTSDB**
OpenTSDB's storage is implemented on top of Hadoop and HBase
easy to scale OpenTSDB horizontally

**Grafana**
webui and use d3 so it's very fast by running on gpu
