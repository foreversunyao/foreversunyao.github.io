---
layout: post
title: "Codility CountDiv/"
date: 2015-01-11 08:25:06
description: Algorithm 
tags:
 - code
---


**1. CountDiv**
```
def solution(A, B, K):
    # write your code in Python 3.6
    if A % K ==0:
        return (B - A) // K + 1
    else:
        return (B - (A - A % K)) // K
def solution(A, B, K):
    # write your code in Python 3.6
    border = 0
    if A % K ==0 or B % K == 0:
        border = 1
    if A < K and B < K:
        return border
    elif A < K and B > K:
        return int((B - K)/K) + 1 + border
    else:
        return int((B-A)/K) + border

```

**2.Passing Cars**
```
def solution(A):
    # write your code in Python 3.6
    count = 0
    zero_count = 0
    one_count = 0
    for i in range(len(A)):
        if A[i] == 0:
            zero_count = zero_count + 1
        if A[i] == 1 and zero_count > 0:
            count = count + zero_count
    return count
```
