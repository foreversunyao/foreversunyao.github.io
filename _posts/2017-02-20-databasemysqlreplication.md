---
layout: post
title: "Database MySQL Replication"
date: 2017-01-05 10:25:06
description: MySQL Replication
tags: 
 - database
---

**MySQL Replication**

Binlog dump thread. The master creates a thread to send the binary log contents to a slave when the slave connects. This thread can be identified in the output of SHOW PROCESSLIST on the master as the Binlog Dump thread.
The binary log dump thread acquires a lock on the master's binary log for reading each event that is to be sent to the slave. As soon as the event has been read, the lock is released, even before the event is sent to the slave.
Slave I/O thread. When a START SLAVE statement is issued on a slave server, the slave creates an I/O thread, which connects to the master and asks it to send the updates recorded in its binary logs.
The slave I/O thread reads the updates that the master's Binlog Dump thread sends (see previous item) and copies them to local files that comprise the slave's relay log.

    current binlog write design:
        acquire LOCK_log
        write log event to binlog
        release LOCK_log
        signal update
      current dump thread design:
        while client is not killed:
          acquire LOCK_log
          read event from binlog
          release LOCK_log
          if EOF was reached in the previous read:
            acquire LOCK_log
            wait for update signal
            read event from binlog
            release LOCK_log

![img]({{ '/assets/images/database/MySQL-Replication.jpg' | relative_url }}){: .center-image }*(°0°)*


**Semi_Replication**

![img]({{ '/assets/images/database/semi-rep-no-Phantom-read.png' | relative_url }}){: .center-image }*(°0°)*

With this feature, semi-synchronous replication is able to guarantee:
All committed transaction are already replicated to at least one slave in case of a master crash.
That is obvious, because it cannot commit to storage engine unless the slave acknowledgement is received(or timeout).

It brings a couple of benefits to users:
Strong Data Integrity with no phantom read.
Ease recovery process of crashed semi-sync master servers.  

![img]({{ '/assets/images/database/semi-rep-Phantom-read-but-fast.png' | relative_url }}){: .center-image }*(°0°)*

"Engine Commit" makes data permanent and release locks on the data. So other sessions can reach the data since then, even if the session is still waiting for the acknowledgement. It will cause phantom read if master crashes and slave takes work over.
To make the crashed master server before MySQL 5.7.2 to work again, users need to:
Manually truncate the binlog events which are not replicated.
Manually rollback the transactions which are committed by not replicated.
Since this feature guarantees all committed transactions are replicated already, so 2nd step is not
needed any more.
