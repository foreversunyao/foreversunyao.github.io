---
layout: post
title: "AWS kinesis"
date: 2021-11-22 10:25:06
description: aws, kinesis
tags:
 - cloud
---

# Kinesis
Amazon Kinesis is a managed, scalable, cloud-based service that allows real-time processing of streaming large amount of data per second.



# Use cases
- Data log and data feed intake
- Real-time graphs
- Real-time data analytics

# API
```
	s := session.New(&aws.Config{Region: aws.String(*region)})
	kc := kinesis.New(s)

	streamName := aws.String(*stream)
```
# Metrics
1. GetRecords.IteratorAgeMilliseconds : Age is the difference between the current time and when the last record of the GetRecords call was written to the stream.
2. GetRecords.Latency: The time taken per GetRecords operation, measured over the specified time period.
3. GetRecords.Records
4. IncomingRecords/IncomingBytes
5. PutRecords.ThrottledRecords: The number of records rejected due to throttling in a PutRecords operation per Kinesis data stream, measured over the specified time period.


# Limits
[refer](https://docs.aws.amazon.com/kinesis/latest/dev/service-sizes-and-limits.html)
