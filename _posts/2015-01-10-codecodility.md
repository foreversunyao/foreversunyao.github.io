---
layout: post
title: "Codility PermCheck/"
date: 2015-01-10 08:25:06
description: Algorithm 
tags:
 - code
---


**1. PermCheck**
```
def solution(A):
    # write your code in Python 3.6
    B = [-1 for x in range(0,len(A)+1)]
    
    for i in range(len(A)):
        if A[i] > len(A):
            return 0
        else :
            B[A[i]] = 0
    for i in range(1,len(B)):
        if B[i] == -1:
            return 0
    return 1   
```
 
