---
layout: post
title: "Java connection pool"
date: 2024-06-19 10:50:06
description: app connectivity issue, connection pool, java
tags: 
 - code
---


[refer](https://community.snowflake.com/s/article/Hikari-Connection-Pool-Timeout-Error-java-sql-SQLTransientConnectionException-pool-name-Connection-is-not-available-request-timed-out-after-n-ms)

#Possible casues

```
A connection pool timeout like that shown in the example above may not immediately indicate a general connectivity issue between the application and the target account. In fact, the underlying cause may be due to any of the following scenarios:
Establishing the particular connection took longer than 30 seconds.
All connections in the pool were in use, and none of them were released in time for the requesting thread to use. Possible causes for this scenario include:
A connection leak wherein threads hold onto a connection and never call the close() method in order to return the connection object back to the pool
The queries submitted to all active connections in the pool took longer than 30 seconds (NOTE: This includes all operations in the query lifecycle, including execution, downloading, and processing results)
An application load issue where the rate of new threads requesting new connections far exceeds the rate of connections being closed
```
