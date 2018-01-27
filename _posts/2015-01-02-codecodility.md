---
layout: post
title: "Codility TapeEquilibrium/FrogJmp/PermMissingElem"
date: 2015-01-02 12:25:06
description: Algorithm
tags:
 - code
---


** 1. TapeEquilibrium **
```
def solution(A):
    # write your code in Python 3.6
    left = A[0]
    right = 0
    for i in range(1,len(A)):
        right =  right + A[i] 
    min = abs(left - right)
    for i in range(1,len(A)-1):
        left = left + A[i]
        right = right - A[i]
        if abs(left - right)<min:
            min = abs(left - right)
    return min
```
 

** 2. FrogJmp **
```
import math
def solution(X, Y, D):
    # write your code in Python 3.6
    if X == Y:
        return 0
    else: 
        return (math.ceil((Y-X)/D))
```

** 3. PermMissingElem **
```
def solution(A):
    # write your code in Python 3.6
    B = [0 for i in range(len(A)+2)]
    for i in range(0,len(A)):
        B[A[i]] = 1
    for i in range(1,len(B)):
        if B[i] == 0:
            return i
```
