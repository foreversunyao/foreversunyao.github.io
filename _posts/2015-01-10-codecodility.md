---
layout: post
title: "Codility PermCheck/FrogRiverOne/MissingInteger/MaxCounters"
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

**2. FrogRiverOne**
```
def solution(X, A):
    # write your code in Python 3.6
    
    B = [-1 for x in range(X+1)]
    leaves = 0
    for i in range(len(A)):
        if B[A[i]] == -1:
            leaves = leaves + 1
            B[A[i]] = 1
        if leaves == X:
            return i
    for i in range(1,len(B)):
        if B[i] == -1:
            return -1
```

**3.MissingInteger**
```
def solution(A):
    # write your code in Python 3.6
    B = [-1 for x in range(len(A)+1)]
    for i in range(len(A)):
        if A[i] > 0 and A[i] < len(B):
            B[A[i]] = 1
    for i in range(1,len(B)):
        if B[i] == -1:
            return i
    return len(A)+1
```

**4.MaxCounters** 
```
### need to be improved
def solution(N, A):
    # write your code in Python 3.6
    before_max =0
    current_max = 0
    n_array = [0 for x in range(N+1)]
    for i in range(len(A)):
        if A[i] <= N and A[i] >=1 and n_array[A[i]] < before_max:
                n_array[A[i]] = before_max + 1
                if  n_array[A[i]] > current_max:
                    current_max = n_array[A[i]]
        elif A[i] <= N and A[i] >=1 and n_array[A[i]] >= before_max:
                n_array[A[i]] = n_array[A[i]] + 1
                if n_array[A[i]] > current_max:
                    current_max =  n_array[A[i]]
        elif A[i] == N + 1:
            before_max = current_max
        else:
            pass
    for i in range(1,len(n_array)):
        if n_array[i] < before_max:
            n_array[i] = before_max
    return n_array[1:]

def solution(N, A):
    # write your code in Python 3.6
    before_max =0
    current_max = 0
    n_array = [0 for x in xrange(N+1)]
    for i in range(len(A)):
        if A[i] <= N:
            n_array[A[i]] =  max(before_max+1,n_array[A[i]] + 1)
            if current_max < n_array[A[i]]:
                current_max =  n_array[A[i]]
        else :
            before_max = current_max
    for i in range(1,len(n_array)):
        if n_array[i] < before_max:
            n_array[i] = before_max
    return n_array[1:]
``` 
