---
layout: post
title: "Prometheus(WIP)"
date: 2020-09-15 10:25:06
description: prom, ha, thanos, OOM, biggest metrics
tags:
 - devops
---

**prometheus**


**OOM**
- which metrics are using the most resources
topk(10, count by (__name__)({__name__=~".+"}))
topk(10, count by (__name__, job)({__name__=~".+"}))
- which jobs have the most time series
topk(10, count by (job)({__name__=~".+"}))

**ha**
[refer](https://www.metricfire.com/blog/ha-kubernetes-monitoring-using-prometheus-and-thanos/)
