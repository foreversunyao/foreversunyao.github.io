---
layout: post
title: "Database MySQL MVCC"
date: 2017-01-05 10:25:06
description: MySQL MVCC
tags: 
 - database
---

**MySQL MVCC**

InnoDB is a multi-versioned storage engine: it keeps information about old versions of changed rows, to support transactional features such as concurrency and rollback. This information is stored in the tablespace in a data structure called a rollback segment (after an analogous data structure in Oracle). InnoDB uses the information in the rollback segment to perform the undo operations needed in a transaction rollback. It also uses the information to build earlier versions of a row for a consistent read. Internally, InnoDB adds three fields to each row stored in the database. A 6-byte DB_TRX_ID field indicates the transaction identifier for the last transaction that inserted or updated the row. Also, a deletion is treated internally as an update where a special bit in the row is set to mark it as deleted. Each row also contains a 7-byte DB_ROLL_PTR field called the roll pointer. The roll pointer points to an undo log record written to the rollback segment. If the row was updated, the undo log record contains the information necessary to rebuild the content of the row before it was updated. A 6-byte DB_ROW_ID field contains a row ID that increases monotonically as new rows are inserted. If InnoDB generates a clustered index automatically, the index contains row ID values. Otherwise, the DB_ROW_ID column does not appear in any index. Undo logs in the rollback segment are divided into insert and update undo logs. Insert undo logs are needed only in transaction rollback and can be discarded as soon as the transaction commits. Update undo logs are used also in consistent reads, but they can be discarded only after there is no transaction present for which InnoDB has assigned a snapshot that in a consistent read could need the information in the update undo log to build an earlier version of a database row.

      TRANSACTION 0 600, ACTIVE 4 sec, process no 3396, OS thread id 1148250464, thread declared inside InnoDB 442
      mysql tables in use 1, locked 0
      MySQL thread id 8079, query id 728899 localhost baron Sending data
      select sql_calc_found_rows * from b limit 5
      Trx read view will not see trx with id>= 0 601, sees <0 596 

![img]({{ '/assets/images/database/readview.png' | relative_url }}){: .center-image }*(°0°)*

ReadView build: RR: each transaction start(first statement in transaction) RC: each statment


