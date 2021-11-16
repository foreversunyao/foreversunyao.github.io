---
layout: post
title: "System troubleshoot"
date: 2021-10-14 10:25:06
description: troubleshooting, improvements
tags:
 - systemdesign
---

**troubleshooting flowchart**
![img]({{ '/assets/images/cloud/system_troubleshooting.png' | relative_url }}){: .center-image }*(°0°)*

**type of errors**
1, downstream
2, config change
3, load change
```
top, htop
```
4, code change
5, memory leak
```
vmstat, free
```
6, CPU usage
```
mpstat
```
7, disk IO
```
iotop, iostat, sar
```
8, network failures
```
nc, netstat, traceroute/6, mtr, ping/6, route, tcpdump, ss, ip
```
9, hosts issues
```
Dmesg -- kernel errors
lspci, lsblk, lscpu, lsscsi,
/var/log/messages -- system app/service related errors
```
10, dns
```
dig, host, nslookup
```
11, app
```
strace
profiling
perf
```
12, http/https
```
curl, wget
```
13, other
```
lsof
sysctl
```
14, log
```
/var/log/messages -- system app/service related errors
Dmesg -- kernel errors
```
**tools**

