---
layout: post
title: "Linux troubleshoot"
date: 2019-01-01 08:25:06
description: 
tags:
 - linux
---

## process
1. run command with same env
```
ls /proc/pid
cat /proc/pid/environ
export export XDG_RUNTIME_DIR=/run/user/<get from environ>
run specific command
```
