---
layout: post
title: "Database MySQL IO"
date: 2017-03-11 09:25:06
description: MySQL IO, Double Write, Commit, Group Commit
tags: 
 - database
---

**MySQL IO **


![img]({{ '/assets/images/database/Double-Write.jpg' | relative_url }}){: .center-image }*(°0°)*

It is needed to archive data safety in case of partial page writes. Innodb does not log full pages to the log files, but uses what is called “physiological” logging which means log records contain page number for the operation as well as operation data (ie update the row) and log sequence information. Such logging structure is geat as it require less data to be written to the log, however it requires pages to be internally consistent. It does not matter which page version it is – it could be “current” version in which case Innodb will skip page upate operation or “former” in which case Innodb will perform update. If page is inconsistent recovery can’t proceed.


![img]({{ '/assets/images/database/Two-Phase-Commit.png' | relative_url }}){: .center-image }*(°0°)*

![img]({{ '/assets/images/database/MySQL-Group-Commit.jpg' | relative_url }}){: .center-image }*(°0°)*

In the flush stage, all the threads that registered will have their caches written to the binary log. Since all the transactions are written to an internal I/O cache, the last part of the stage is writing the memory cache to disk (which means it is written to the file pages, also in memory). In the sync stage, the binary log is synced to disk according to the settings of sync_binlog. If sync_binlog=1 all sessions that were flushed in the flush stage will be synced to disk each time. In the commit stage, the sessions will that registered for the stage will be committed in the engine in the order they registered, all work is here done by the stage leader. Since order is preserved in each stage of the commit procedure, the writes and the commits will be made in the same order.


