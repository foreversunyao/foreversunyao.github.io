---
layout: post
title: "Database Hbase"
date: 2017-06-01 20:25:06
description: Hbase 
tags: 
 - database
---
[refer](https://data-flair.training/blogs/hbase-architecture/#:~:text=In%20HBase%20Architecture%2C%20a%20region,these%20servers%20serves%20the%20data.)

**componets**
![img]({{ '/assets/images/database/hbase_arch1.png' | relative_url }}){: .center-image }*(°0°)*
Hbase Hmaster, Region Server and Zookeepr, HDFS
- HBase uses ZooKeeper as a distributed coordination service. Basically, which servers are alive and available is maintained by Zookeeper, and also it provides server failure notification. 

- The HMaster in the HBase is responsible for
Performing Administration
Managing and Monitoring the Cluster
Assigning Regions to the Region Servers
Controlling the Load Balancing and Failover

- the HRegionServer perform the following work
Hosting and managing Regions
Splitting the Regions automatically
Handling the read/write requests
Communicating with the Clients directly

- Hadoop
HDFS replicates the write-ahead logs as well as HFile blocks. However, these replication process of HFile block happens automatically.

**region server components**
- WAL
It is a file on the distributed file system. Basically, to store new data that hasn’t yet been persisted to permanent storage, we use the WAL. Moreover, we also use it for recovery in the case of failure.
Write ahead log
- MemStore
It is the write cache. The main role of MemStore is to store new data which has not yet been written to disk. Also, before writing to disk, it gets sorted.
- Hfiles
These files store the rows as sorted KeyValues on disk.


**write and read**
[refer](https://www.guru99.com/hbase-architecture-data-flow-usecases.html)
![img]({{ '/assets/images/database/hbase_w_r.png' | relative_url }}){: .center-image }*(°0°)*

**table**
Tables are sorted by Row in lexicographical order
Table schema only defines its column families
Each family consists of any number of columns
Each column consists of any number of versions
Columns only exist when inserted, NULLs are free
Columns within a family are sorted and stored together
Everything except table names are byte[]
Hbase Table format (Row, Family:Column, Timestamp) -> Value

**failover**
[refer](https://nag-9-s.gitbook.io/hbase/hbase-architecture/fault-tolerance)
![img]({{ '/assets/images/database/hbase_recovery.png' | relative_url }}){: .center-image }*(°0°)*
ZooKeeper notifies to the HMaster about the failure, whenever a Region Server fails.
Afterward, too many active Region Servers, HMaster distributes and allocates the regions of crashed Region Server. Also, the HMaster distributes the WAL to all the Region Servers, in order to recover the data of the MemStore of the failed Region Server.
Furthermore, to build the MemStore for that failed region’s column family, each Region Server re-executes the WAL.
However, Re-executing that WAL means updating all the change that was made and stored in the MemStore file because, in WAL, the data is written in timely order.
Therefore, we recover the MemStore data for all column family just after all the Region Servers executes the WAL.
