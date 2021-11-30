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
- caculate
[refer](https://www.robustperception.io/how-much-ram-does-prometheus-2-x-need-for-cardinality-and-ingestion)
- api(tsdb)
```
GET /api/v1/status/tsdb
headStats: This provides the following data about the head block of the TSDB:
numSeries: The number of series.
chunkCount: The number of chunks.
minTime: The current minimum timestamp in milliseconds.
maxTime: The current maximum timestamp in milliseconds.
seriesCountByMetricName: This will provide a list of metrics names and their series count.
labelValueCountByLabelName: This will provide a list of the label names and their value count.
memoryInBytesByLabelName This will provide a list of the label names and memory used in bytes. Memory usage is calculated by adding the length of all values for a given label name.
seriesCountByLabelPair This will provide a list of label value pairs and their series count.
```

**ha**
[refer](https://www.metricfire.com/blog/ha-kubernetes-monitoring-using-prometheus-and-thanos/)

**high memory consumption**
[refer](https://source.coveo.com/2021/03/03/prometheus-memory/)

remove unuseful labels

```
go tool pprof -symbolize=remote -inuse_space https://promXXX/debug/pprof/heap
File: prometheus
Type: inuse_space
Time: Apr 24, 2019 at 4:20pm (CEST)
Entering interactive mode (type "help" for commands, "o" for options)
(pprof) top
Showing nodes accounting for 8839.83MB, 84.87% of 10415.77MB total
Dropped 398 nodes (cum <= 52.08MB)
Showing top 10 nodes out of 64
      flat  flat%   sum%        cum   cum%
 1628.82MB 15.64% 15.64%  1628.82MB 15.64%  github.com/prometheus/tsdb/index.(*decbuf).uvarintStr /app/vendor/github.com/prometheus/tsdb/index/encoding_helpers.go
 1233.86MB 11.85% 27.48%  1234.86MB 11.86%  github.com/prometheus/prometheus/pkg/textparse.(*PromParser).Metric /app/pkg/textparse/promparse.go
...
```

**Tune**
[optimising startup](https://www.robustperception.io/optimising-startup-time-of-prometheus-2-6-0-with-pprof)


