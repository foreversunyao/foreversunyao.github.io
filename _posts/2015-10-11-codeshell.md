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
