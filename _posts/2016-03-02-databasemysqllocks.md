---
layout: post
title: "Database MySQL Locks"
date: 2016-03-02 18:25:06
description: MySQL Locks
tags: 
 - database
---

**MySQL Locks**

mysql> select * from information_schema.innodb_trx\G
*************************** 1. row ***************************
                    trx_id: 502C93962    --may be not created if read only & non-locking()
                 trx_state: RUNNING      --RUNNING,LOCK WAIT,ROLLING BACK or COMMITTING
               trx_started: 2017-07-12 08:33:49
     trx_requested_lock_id: NULL         -- not NULL if waiting. See INNODB_LOCK.LOCK_ID
          trx_wait_started: NULL         
                trx_weight: 0            -- depends on num. of rows changed and locked, nontran tables
       trx_mysql_thread_id: 99292109     -- See Id in PROCESSLIST
                 trx_query: NULL         -- current query executed(1024 utf8)
       trx_operation_state: NULL         -- see thread states...
         trx_tables_in_use: 0
         trx_tables_locked: 0            -- tables with records locked
          trx_lock_structs: 0            -- number of lock structures
     trx_lock_memory_bytes: 376          -- memory for lock structures
           trx_rows_locked: 0            -- approx., may include delete-marked nontran tables
         trx_rows_modified: 0            -- rows modified or inserted
   trx_concurrency_tickets: 0            --  these columns are properly explained in the manual
       trx_isolation_level: REPEATABLE READ
         trx_unique_checks: 1
    trx_foreign_key_checks: 1
trx_last_foreign_key_error: NULL         -- varchar(256) utf8
 trx_adaptive_hash_latched: 0
 trx_adaptive_hash_timeout: 10000
          trx_is_read_only: 0
trx_autocommit_non_locking: 0            -- non-locking SELECT in autocommit mode we skip this call protected by sys_mutex: --trx->id = trx_sys_get_new_trx_id();(trx_id = 0)

mysql> select * from information_schema.innodb_locks\G
*************************** 1. row ***************************
    lock_id: 64049:498:3:4                -- trx id:space no:page no:heap no or trx_id:table id
    lock_trx_id: 64049                    -- join with INNODB_TRX on TRX_ID to get details
    lock_mode: S                          -- row->lock_mode = lock_get_mode_str(lock)
    lock_type: RECORD                     -- row->lock_type = lock_get_type_str(lock)
    lock_table: `test`.`t`                -- lock_get_table_name(lock).m_name ...
    lock_index: PRIMARY                   -- index name for record lock or NULL
    lock_space: 498                       -- space no for record lock or NULL
    lock_page: 3                          -- page no for record lock or NULL
    lock_rec: 4                           -- heap no for record lock or NULL
    lock_data: 6                          -- key values for index, supremum/infimum pseudo-record, or NULL (table lock or page is not in buf. pool)

mysql> select * from information_schema.innodb_lock_waits\G
*************************** 1. row ***************************
    requesting_trx_id: 69360                  -- join INNODB_TRX on TRX_ID
    requested_lock_id: 69360:507:3:8          -- join INNODB_LOCKS on LOCK_ID
    blocking_trx_id: 69355                    -- 
    blocking_lock_id: 69355:507:3:8    



metadata_locks
MySQL (since 5.5.3) uses metadata locking to manage concurrent access to database objects and to ensure data consistency.(DDL and transaction)

Table_locks
Table level S and X locks Table level IS and IX (intention) locks Intention shared (IS): Transaction T intends to set S locks on individual rows in table t • Intention exclusive (IX): Transaction T intends to set X locks on those rows • Before a transaction can acquire an S lock on a row in table t, it must first acquire an IS or stronger lock on table • Before a transaction can acquire an X lock on a row, it must first acquire an IX lock on t • Intention locks do not block anything except full table requests (for example, LOCK TABLES ... WRITE or ALTER TABLE)

auto_inc locks
InnoDB uses a special lock called the table-level AUTO-INC lock for inserts into tables with AUTO_INCREMENT columns. This lock is normally held to the end of the statement (not to the end of the transaction)

row locks
Record lock is a lock on index record.There are two types of record locks in InnoDB – implicit (logical entity) and explicit.
Gap lock is a on a gap between index records, or a lock on the gap before the first or after the last index record.Usually gap locks are set as part of next-key lock, but may be set separately! Next-key lock is a is a combination of a record lock on the index record and a gap lock on the gap before the index record.
A type of gap lock called an insert intention gap lock is set by INSERT operations prior to row insertion. This lock signals the intent to insert in such a way that multiple transactions inserting into the same index gap need not wait for each other if they are not inserting at the same position within the gap.

As with READ COMMITTED:
READ-COMMITTED creates a situation of non-repeatable read, hence its not safe for statement-based replication. Hence, when using statement-based replication either use SERIALIZABLE or REPEATABLE-READ isolation level.
“Gap locking is disabled for searches and index scans and is used only for foreign-key constraint checking and duplicate-key checking.”
“Record locks for nonmatching rows are released after MySQL has evaluated the WHERE condition.”
“For UPDATE statements, InnoDB does a “semi-consistent” read, such that it returns the latest committed version to MySQL.
