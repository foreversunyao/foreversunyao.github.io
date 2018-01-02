I‘d like to use images to describe technology, and I think it is better to make technology to be understood.  
Most of these images are drawn by myself, and others are copies from books or blogs.  
All these images are drawn by using "www.draw.io", it is really a very cool tool.

# MySQl-related  
__MySQL QPS__  
~~~~  
mysqladmin -P3306 -uroot -p -h127.0.0.1 -r -i 1 ext |\
awk -F"|" \
"BEGIN{ count=0; }"\
'{ if($2 ~ /Variable_name/ && ((++count)%20 == 1)){\
    print "----------|---------|--- MySQL Command Status --|----- Innodb row operation ----|-- Buffer Pool Read --";\
    print "---Time---|---QPS---|select insert update delete|  read inserted updated deleted|   logical    physical";\
}\
else if ($2 ~ /Queries/){queries=$3;}\
else if ($2 ~ /Com_select /){com_select=$3;}\
else if ($2 ~ /Com_insert /){com_insert=$3;}\
else if ($2 ~ /Com_update /){com_update=$3;}\
else if ($2 ~ /Com_delete /){com_delete=$3;}\
else if ($2 ~ /Innodb_rows_read/){innodb_rows_read=$3;}\
else if ($2 ~ /Innodb_rows_deleted/){innodb_rows_deleted=$3;}\
else if ($2 ~ /Innodb_rows_inserted/){innodb_rows_inserted=$3;}\
else if ($2 ~ /Innodb_rows_updated/){innodb_rows_updated=$3;}\
else if ($2 ~ /Innodb_buffer_pool_read_requests/){innodb_lor=$3;}\
else if ($2 ~ /Innodb_buffer_pool_reads/){innodb_phr=$3;}\
else if ($2 ~ /Uptime / && count >= 2){\
  printf(" %s |%9d",strftime("%H:%M:%S"),queries);\
  printf("|%6d %6d %6d %6d",com_select,com_insert,com_update,com_delete);\
  printf("|%6d %8d %7d %7d",innodb_rows_read,innodb_rows_inserted,innodb_rows_updated,innodb_rows_deleted);\
  printf("|%10d %11d\n",innodb_lor,innodb_phr);\
}}'
~~~~  

---

__Query Indexes__  

SELECT table_name AS `Table`,
       index_name AS `Index`,
       GROUP_CONCAT(column_name ORDER BY seq_in_index) AS `Columns`
FROM information_schema.statistics
WHERE table_schema = 'sakila'
GROUP BY 1,2;

---

__RPO and RTO__  

![alt text](https://github.com/foreversunyao/MySQL-related/blob/master/RPO%20and%20RTO.jpg "RPO and RTO")  
RPO: recovery point objective is the acceptable data-logss time caused by a failure.The amount of data loss is measured in time.  
RTO: recovery time objective is the time it takes for a system to recover from a failure, it's the length of the time until the system service level is reached after an outage.

__MySQL HA(MySQL high availability system(I designed))__  
Based on KeepAlived
![alt_text](https://github.com/foreversunyao/MySQL-related/blob/master/MySQL%20HA%201.png)   
Based on DNS
![alt_text](https://github.com/foreversunyao/MySQL-related/blob/master/MySQL%20HA%202.png)  
MySQL replication is based on semi-sync to try to keep data consistent.

__MySQL MVCC__  
InnoDB is a multi-versioned storage engine: it keeps information about old versions of changed rows, to support transactional features such as concurrency and rollback. This information is stored in the tablespace in a data structure called a rollback segment (after an analogous data structure in Oracle). InnoDB uses the information in the rollback segment to perform the undo operations needed in a transaction rollback. It also uses the information to build earlier versions of a row for a consistent read.
Internally, InnoDB adds three fields to each row stored in the database. A 6-byte DB_TRX_ID field indicates the transaction identifier for the last transaction that inserted or updated the row. Also, a deletion is treated internally as an update where a special bit in the row is set to mark it as deleted. Each row also contains a 7-byte DB_ROLL_PTR field called the roll pointer. The roll pointer points to an undo log record written to the rollback segment. If the row was updated, the undo log record contains the information necessary to rebuild the content of the row before it was updated. A 6-byte DB_ROW_ID field contains a row ID that increases monotonically as new rows are inserted. If InnoDB generates a clustered index automatically, the index contains row ID values. Otherwise, the DB_ROW_ID column does not appear in any index.
Undo logs in the rollback segment are divided into insert and update undo logs. Insert undo logs are needed only in transaction rollback and can be discarded as soon as the transaction commits. Update undo logs are used also in consistent reads, but they can be discarded only after there is no transaction present for which InnoDB has assigned a snapshot that in a consistent read could need the information in the update undo log to build an earlier version of a database row.  
~~~~ 
  TRANSACTION 0 600, ACTIVE 4 sec, process no 3396, OS thread id 1148250464, thread declared inside InnoDB 442
  mysql tables in use 1, locked 0
  MySQL thread id 8079, query id 728899 localhost baron Sending data
  select sql_calc_found_rows * from b limit 5
  Trx read view will not see trx with id>= 0 601, sees <0 596 
~~~~  
![alt_text](https://github.com/foreversunyao/MySQL-related/blob/master/readview.png) 
   ReadView build:
   RR: every transaction start(first statement in transaction)
   RC: every statment  
   
__MySQL Backup and Restoration__  
![alt_text](https://github.com/foreversunyao/MySQL-related/blob/master/MySQL%20Backup.jpg)  

__MySQL Replication__     
![alt_text](https://github.com/foreversunyao/MySQL-related/blob/master/MySQL%20Replication.jpg)  
Binlog dump thread.  The master creates a thread to send the binary log contents to a slave when the slave connects. This thread can be identified in the output of SHOW PROCESSLIST on the master as the Binlog Dump thread.  
The binary log dump thread acquires a lock on the master's binary log for reading each event that is to be sent to the slave. As soon as the event has been read, the lock is released, even before the event is sent to the slave.  
Slave I/O thread.  When a START SLAVE statement is issued on a slave server, the slave creates an I/O thread, which connects to the master and asks it to send the updates recorded in its binary logs.  
The slave I/O thread reads the updates that the master's Binlog Dump thread sends (see previous item) and copies them to local files that comprise the slave's relay log.  
~~~~
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
 ~~~~

#### Semi_Replication  
![alt_text](https://github.com/foreversunyao/MySQL-related/blob/master/semi-rep(no%20Phantom%20read).png)  
With this feature, semi-synchronous replication is able to guarantee:
All committed transaction are already replicated to at least one slave in case of a master crash.
That is obvious, because it cannot commit to storage engine unless the slave acknowledgement is received(or timeout).

It brings a couple of benefits to users:
Strong Data Integrity with no phantom read.
Ease recovery process of crashed semi-sync master servers.  
![alt_text](https://github.com/foreversunyao/MySQL-related/blob/master/semi-rep(Phantom%20read%20but%20fast).png)  
"Engine Commit" makes data permanent and release locks on the data. So other sessions can reach the data since then, even if the session is still waiting for the acknowledgement. It will cause phantom read if master crashes and slave takes work over.
To make the crashed master server before MySQL 5.7.2 to work again, users need to:
Manually truncate the binlog events which are not replicated.
Manually rollback the transactions which are committed by not replicated.
Since this feature guarantees all committed transactions are replicated already, so 2nd step is not
needed any more.  




The state of this thread is shown as Slave_IO_running in the output of SHOW SLAVE STATUS or as Slave_running in the output of SHOW STATUS.

Slave SQL thread.  The slave creates an SQL thread to read the relay log that is written by the slave I/O thread and execute the events contained therein.  
__MySQL XA__  
![alt_text](https://github.com/foreversunyao/MySQL-related/blob/master/MySQl%20XA.png)
__MySQL Turning__  
![alt_text](https://github.com/foreversunyao/MySQL-related/blob/master/MySQL%20Turning.png)  
__MySQL IO__  
![alt_text](https://github.com/foreversunyao/MySQL-related/blob/master/MySQL%20IO.png)  
###### DoubleWrite:
![alt_text](https://github.com/foreversunyao/MySQL-related/blob/master/Double%20Write.jpg)  
 It is needed to archive data safety in case of partial page writes. Innodb does not log full pages to the log files, but uses what is called “physiological” logging which means log records contain page number for the operation as well as operation data (ie update the row) and log sequence information. Such logging structure is geat as it require less data to be written to the log, however it requires pages to be internally consistent. It does not matter which page version it is – it could be “current” version in which case Innodb will skip page upate operation or “former” in which case Innodb will perform update. If page is inconsistent recovery can’t proceed.  
###### Two Phase Commit:  
![alt_text](https://github.com/foreversunyao/MySQL-related/blob/master/Two%20Phase%20Commit.png)  
###### GroupCommit:   
![alt_text](https://github.com/foreversunyao/MySQL-related/blob/master/MySQL%20Group%20Commit.jpg)  
In the flush stage, all the threads that registered will have their caches written to the binary log. Since all the transactions are written to an internal I/O cache, the last part of the stage is writing the memory cache to disk (which means it is written to the file pages, also in memory).
In the sync stage, the binary log is synced to disk according to the settings of sync_binlog. If sync_binlog=1 all sessions that were flushed in the flush stage will be synced to disk each time.
In the commit stage, the sessions will that registered for the stage will be committed in the engine in the order they registered, all work is here done by the stage leader. Since order is preserved in each stage of the commit procedure, the writes and the commits will be made in the same order.   

__MySQL Architecture__  
![alt_text](https://github.com/foreversunyao/MySQL-related/blob/master/MySQL%20Architecture.png)  

__MySQL Lock__   
~~~~
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
~~~~
###### metadata_locks  
MySQL (since 5.5.3) uses metadata locking to manage concurrent access to database objects and to
ensure data consistency.(DDL and transaction)
###### Table_locks  
Table level S and X locks
Table level IS and IX (intention) locks
Intention shared (IS): Transaction T intends to set S locks on individual rows in table t
• Intention exclusive (IX): Transaction T intends to set X locks on those rows
• Before a transaction can acquire an S lock on a row in table t, it must first acquire an IS or
stronger lock on table
• Before a transaction can acquire an X lock on a row, it must first acquire an IX lock on t
• Intention locks do not block anything except full table requests (for example, LOCK TABLES ...
WRITE or ALTER TABLE)
###### auto_inc locks  
 InnoDB uses a special lock called the table-level AUTO-INC lock for inserts into tables with
AUTO_INCREMENT columns. This lock is normally held to the end of the statement (not to
the end of the transaction)
###### row locks  
Record lock is a lock on index record.There are two types of record locks in InnoDB – implicit (logical entity) and explicit.  
Gap lock is a on a gap between index records, or a lock on the gap before the first or after the
last index record.Usually gap locks are set as part of next-key lock, but may be set separately!
Next-key lock is a is a combination of a record lock on the index record and a gap lock on the
gap before the index record.  
A type of gap lock called an insert intention gap lock is set by INSERT operations prior to row
insertion. This lock signals the intent to insert in such a way that multiple transactions inserting
into the same index gap need not wait for each other if they are not inserting at the same
position within the gap.  

###### As with READ COMMITTED:  
READ-COMMITTED creates a situation of non-repeatable read, hence its not safe for statement-based replication. Hence, when using statement-based replication either use SERIALIZABLE or REPEATABLE-READ isolation level.  
“Gap locking is disabled for searches and index scans and is used only for foreign-key
constraint checking and duplicate-key checking.”  
“Record locks for nonmatching rows are released after MySQL has evaluated the WHERE
condition.”  
“For UPDATE statements, InnoDB does a “semi-consistent” read, such that it returns the
latest committed version to MySQL.    

__MySQL Security__  
Poor Configurations , Over Privileged Accounts, Weak Access Control, Weak Authentication, Weak Auditing, Lack of Encryption, Proper Credential or Key Management, Unsecured Backups, No Monitoring, Poorly Coded Applications.
![alt_text](https://github.com/foreversunyao/MySQL-related/blob/master/MySQL%20security.png)
