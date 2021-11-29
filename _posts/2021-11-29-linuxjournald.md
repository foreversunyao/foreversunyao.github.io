---
layout: post
title: "Journald"
date: 2021-11-29 17:25:06
description: journald, logging, syslog
tags: 
 - linux
---
## journald
- journald is the part of systemd that deals with logging. systemd, at its core, is in charge of managing services: it starts them up and keeps them alive.
- config
```
/etc/systemd/journald.conf
```
## Benefits
1. Indexing
2. Structured logging
3. Access control
4. Automatic log rotation

## vs syslog
Journald provides a good out-of-the-box logging experience for systemd. The trade-off is, journald is a bit of a monolith, having everything from log storage and rotation, to log transport and search. Some would argue that syslog is more UNIX-y: more lenient, easier to integrate with other tools. Which was its main criticism to begin with.
