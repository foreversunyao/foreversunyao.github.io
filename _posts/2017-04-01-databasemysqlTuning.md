---
layout: post
title: "Database MySQL Tuning"
date: 2017-04-01 11:25:06
description: MySQL Performance Tuning
tags: 
 - database
---

Hardware --> OS --> MySQL --> Table --> SQL --> Other alternative

**MySQL Performance Tuning **

 - Try to keep most of data in Memory
	1, Decrease the size of one table to improve index efficiency
        2, Decrease the skew in one table
        3, Add Mem in Buffer Pool if possible, check Buffer pool hit rate parameter

mem used:
used_Mem =
+ key_buffer_size
+ query_cache_size
+ innodb_buffer_pool_size
+ innodb_additional_mem_pool_size
+ innodb_log_buffer_size
+ max_connections *(
       + read_buffer_size
    + read_rnd_buffer_size
    + sort_buffer_size
    + join_buffer_size
    + binlog_cache_size
    + thread_stack
    + tmp_table_size
    + bulk_insert_buffer_size
)

 - Decrease concurrent connection and request to MySQL
 - Decrease the disk io operation
        1, innodb_flush_log_at_trx_commit
        2, sync_binlog
        3, Close slow query and general query if possible
        4, innodb_io_capacity\innodb_write_io_threads\innodb_read_io_threads
        5, increase innodb_log_buffer_size
        6, decrease Handler_read_rnd_next / Com_select
 - Decrease locks
	1, increase table_cache
        2, increase thread_cache_size
        3, increase back_log when numerous short connection
        4, close query_cache
        5, decrease update on single record
        6, decrease deadlock
 - Decrease CPU usages
        1, decrease slow query
        2, decrease locks
        3, perf -p (pidof mysql) to check cpu usages by function

**MySQL Persistence  Tuning **
 - Redo:innodb_flush_log_at_trx_commit
 - Binlog:sync_binlog
 - Replication:semi_sync
 - Binlog Format:binlog_format
   

**Linux Tuning for MySQL**
 - open_files_limit
 - vm.dirty_writeback_centisecs
 - vm.dirty_expire_centisecs
 - vm.swappiness=1
 - enable rps
 - ssd and noop are better
 - tcp connection

[my.cnf.example](https://github.com/foreversunyao/Configuration_Example/blob/master/my.cnf)
[linux for mysql](https://github.com/foreversunyao/Configuration_Example/blob/master/linux4mysql.txt)
[mysql QPS](https://github.com/foreversunyao/Configuration_Example/blob/master/mysqlqps.sh)

![img]({{ '/assets/images/database/MySQL-Tuning.png' | relative_url }}){: .center-image }*(°0°)*


