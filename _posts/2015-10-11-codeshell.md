---
layout: post
title: "Shell"
date: 2015-11-11 08:25:06
description: Algorithm 
tags:
 - code
---

**insert a string after every N lines**
1, sed '0~1000 s/$/new line;/g' < aaa > bbb.new

**date**
1, date -d "2015-12-25" '+%m-%d-%y' &&  date -d "2015-12-25" "+A %A in %B"

**bash parameter test**
```
#!/bin/bash

echo "Using \"\$*\":"
for a in "$*"; do
    echo $a;
done

echo -e "\nUsing \$*:"
for a in $*; do
    echo $a;
done

echo -e "\nUsing \"\$@\":"
for a in "$@"; do
    echo $a;
done

echo -e "\nUsing \$@:"
for a in $@; do
    echo $a;
done
```
