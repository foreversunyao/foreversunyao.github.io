---
layout: post
title: "Database MySQL Sharding"
date: 2017-11-19 20:25:06
description: MySQL Sharding Concept
tags: 
 - database
---

**What is Sharding**
Sharding is a scale-out approach in which database tables are partitioned, and each partition is put on a separate RDBMS server.

**Why MySQL need Sharding **
 - Very large working set
 - Too many writes
 - Hight response time(Slow query or Lock)

**How MySQL Sharding **
 - Partitioning by Application Function
 - Sharding by hash or key(table-->table000..table999)
 - Sharding by hash or key(database-->db00...db99)

**Sharding  Challenges**
 - Sharding key must be chosen and make data evenly 
 - Schema changes 
 - Mapping between sharding key, shards (databases), and physical servers
 - Cross-Node transactions and ACID
 - Application need to "join" the results from different databases
 
 **Some Sharding Tools**
 MySQL Cluster: https://www.mysql.com/products/cluster/
 Proxy: https://github.com/sysown/proxysql
 NewSQL: https://github.com/cockroachdb/cockroach
