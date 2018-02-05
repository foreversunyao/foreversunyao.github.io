---
layout: post
title: "Codility OddOccurrencesInArray/CyclicRotation"
date: 2015-01-05 12:25:06
description: Algorithm 
tags:
 - code
---


**1. OddOccurrencesInArray**
```
def solution(A):
    # write your code in Python 3.6
    result = 0
    for i in range(len(A)):
        result=result ^ A[i]
    print(result)
    
```
 
**2. CyclicRotation**
```
def solution(A, K):
    # write your code in Python 3.6
    B = [0 for x in range(len(A))]
    for i in range(len(A)):
        newpos=(i+K)%(len(A))
        B[newpos]=A[i]
    for i in range(len(B)):
        print(B[i])
```

