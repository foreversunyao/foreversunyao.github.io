---
layout: post
title: "Database MySQL Configuration"
date: 2017-02-01 20:25:06
description: Linux configuration and MySQL configuration example
tags: 
 - database
---

**Linux conf for MySQL**

 - swap
If RAM size is 128GB, the swap size is 128GB.
If RAM size is 64GB, the swap size if 128GB.
If RAM size is 32GB, the swap size if 64GB.
If RAM size is 16GB, the swap size is 32GB.

 - install tools
sysstat
dstat
wget
vim
vixie-cron
lrzsz
screen
htop
bmon
nc
monit
telnet
mtr
nfs-utils
nfs-utils-lib
xinetd
rsync
dmidecode
Percona Xtrabackup
Percona Toolkit for MySQL
ntp
iotop
snmpd

 - fstab

UUID=xxxx /data    ext4    errors=remount-ro,barrier=0,noatime,nodiratime 0 1

 - selinux off

cat /etc/selinux/config | sed 's/SELINUX=enforcing/#SELINUX=enforcing/' > /etc/selinux/config.new
echo "SELINUX=disabled" >> /etc/selinux/config.new
mv -f /etc/selinux/config /etc/selinux/config.original
mv -f /etc/selinux/config.new /etc/selinux/config

 - limits

1. open files description and process
echo "*       soft    nofile  655350" >> /etc/security/limits.conf
echo "*       hard    nofile  655350" >> /etc/security/limits.conf
echo "*       soft    nproc   unlimited" >> /etc/security/limits.conf
echo "*       hard    nproc   unlimited" >> /etc/security/limits.conf
cd /proc/`pidof mysqld`/
echo -n "Max processes=1031955:1031955" > limits
2. Decrease the disk write cache
echo "vm.dirty_writeback_centisecs=100" >> /etc/sysctl.conf
echo "vm.dirty_expire_centisecs=100" >> /etc/sysctl.conf
sysctl -p
3. Change swap configuration
echo "vm.swappiness=1" >> /etc/sysctl.conf
sysctl -p

 - enable rps/rfs
https://gist.github.com/netmarkjp/4bfc10295ba5193e4039


**my.cnf**

[mysql]

##### #  CLIENT
port                           = 3306
socket                         = /var/mysql/mysql.sock

[mysqld]
##### #  GENERAL #
server_id=
report_host                    =
report_port                    = 3306
port                           = 3306
user                           = mysql
default-storage-engine         = InnoDB
socket                         = /var/mysql/mysql.sock
pid-file                       = /var/mysql/mysql.pid

##### #  MyISAM #
key-buffer-size                = 32M
myisam-recover                 = FORCE,BACKUP

##### #  SAFETY #
max-allowed-packet             = 16M
max-connect-errors             = 5
skip-name-resolve
skip-symbolic-links
sql-mode                       = STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
local-infile                   = 0
sysdate-is-now                 = 1
innodb                         = FORCE
innodb-strict-mode             = 1

##### #  DATA STORAGE #
datadir                        = /var/mysql/
tmpdir                         = /var/mysql_tmp

##### #  BINARY LOGGING #
log-bin                        = /var/mysql/mysql-bin
expire-logs-days               = 14
sync-binlog                    = 1/0/1000

##### #  temp setting to reduce IO
binlog-cache-size              = 2M

##### #  Audit #
audit_log_policy               = logins
audit_log_buffer_size          = 32768
audit_log_format               = CSV
audit_log_rotate_on_size       = 1G
audit_log_rotations            = 1

##### #  REPLICATION #
read-only                      = 0
binlog_format                  = row
skip-slave-start               = 1
log-slave-updates              = 1
relay-log                      = /var/mysql/relay-log
slave-net-timeout              = 60
sync-master-info               = 0
sync-relay-log                 = 0
sync-relay-log-info            = 0

##### #  CACHES AND LIMITS #
tmp-table-size                 = 32M
max-heap-table-size            = 32M
query-cache-type               = 0
query-cache-size               = 0
max-connections                = 20000
thread-cache-size              = 100
open-files-limit               = 65535
table-definition-cache         = 4096
table-open-cache               = 10000

##### #  INNODB
innodb-flush-method            = O_DIRECT
innodb-log-files-in-group      = 2
innodb-log-file-size           = 2048M
innodb-flush-log-at-trx-commit = 1/2/0
innodb-file-per-table          = 1
innodb-buffer-pool-size        = 64G
innodb_buffer_pool_instances   = 12
innodb_io_capacity             = 20000
innodb_purge_threads           = 1
innodb_max_dirty_pages_pct     = 60
innodb_log_block_size          = 4096
innodb_write_io_threads        = 16
innodb_read_io_threads         = 8
innodb_file_format             = barracuda

##### #  LOGGING
log_warnings                   = 2
log-error                      = /var/mysql/mysql-error.log
log-queries-not-using-indexes  = 0
slow-query-log                 = 1
slow-query-log-file            = /var/mysql/mysql-slow.log

##### #  extended logging
long_query_time                    = 0.1
slow_query_log_use_global_control  = "log_slow_filter,log_slow_rate_limit,log_slow_verbosity,long_query_time"
log_slow_sp_statements             = 1
slow_query_log_timestamp_always    = 1
slow_query_log_timestamp_precision = microsecond

##### #  Percona stats features
query_response_time_stats      = 1
userstat                       = 1
thread_statistics              = 1



**Enable Security**
/usr/bin/mysql_secure_installation
