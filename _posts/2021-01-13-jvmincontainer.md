---
layout: post
title: "JVM in container"
date: 2021-01-13 12:25:06
description: Java8, Java10+, jvm in container
tags:
 - code
---

**Java8,9**
```
-XX:+UnlockExperimentalVMOptions
-XX:+UseCGroupMemoryLimitForHeap
-XX:MaxRAMFraction
```
**Java10+**
```
-XX:+UseContainerSupport
-XX:MinRAMPercentage
-XX:MaxRAMPercentage
```
**java11**

**jvm**
[refer](https://www.freecodecamp.org/news/garbage-collection-in-java-what-is-gc-and-how-it-works-in-the-jvm/)

**setting**
```
-XX:MinRAMPercentage=60.0 -XX:MaxRAMPercentage=90.0 -XX:+HeapDumpOnOutOfMemoryError
```

[refer](https://merikan.com/2019/04/jvm-in-a-container/)

