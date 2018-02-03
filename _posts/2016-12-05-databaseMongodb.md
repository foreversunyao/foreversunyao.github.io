---
layout: post
title: MongoDB"
date: 2016-12-05 09:25:06
description: a scalability and flexibility document database
tags: 
 - database
---

**Mongodb vs MySQL**

**Mongodb Key Parameters**
 - system:
ulimit:
mongod       soft        nproc        64000
mongod       hard        nproc        64000
mongod       soft        nofile       64000
mongod       hard        nofile       64000

Dirty Ratio and Swappiness:
vm.dirty_ratio = 15
vm.dirty_background_ratio = 5
vm.swappiness = 1

Transparent HugePages:
transparent_hugepage=never

NUMA:
numactl --interleave=all mongod <options here>

{% highlight bash %}
sudo numastat -p $(pidof mongod)
 
Per-node process memory usage (in MBs) for PID 7516 (mongod)
                           Node 0           Total
                  --------------- ---------------
Huge                         0.00            0.00
Heap                        28.53           28.53
Stack                        0.20            0.20
Private                      7.55            7.55
----------------  --------------- ---------------
Total                       36.29           36.29
{% endhighlight %}

IO Scheduler:
deadline or noop

Filesystem and Options:
ext4 rw,seclabel,noatime,data=ordered 0 0

Network:
net.core.somaxconn = 4096
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_intvl = 30
net.ipv4.tcp_keepalive_time = 120
net.ipv4.tcp_max_syn_backlog = 4096

Security:
disable SELinux

*Mongodb Monitor Metrics**

 - mongostat

 - command
db.serverStatus()
db.stats()
db.collection.stats()
db.printReplicationInfo()
rs.status()
db.getProfilingStatus()


