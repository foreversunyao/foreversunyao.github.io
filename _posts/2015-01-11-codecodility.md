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
        elif A[i] == 1:
            count = count + zero_count
	    if count > 1000000000:
	        return -1	
    return count
```

**3.Min Average Two Slice**
```
def solution(A):
    # write your code in Python 3.6[]
    min = (A[0]+A[1])/2.0
    start = 0
    for i in range(len(A)-1):
        if (A[i]+A[i+1])/2.0 <min:
            min = (A[i]+A[i+1])/2.0
            start = i
        if i+2 <=len(A)-1 and (A[i]+A[i+1]+A[i+2])/3.0 < min:
            min = (A[i]+A[i+1]+A[i+2])/3.0
            start = i
        
    return start
```
**4.
```
solution 1:
def solution(S, P, Q):
    # write your code in Python 3.6
    min = 4
    dictx = {'A': 1,'C': 2,'G': 3,'T': 4}
    result = [ 0 for x in range(len(P))]
    for i in range(len(P)):
        left = P[i]
        right = Q[i]
        if left == right:
            result[i] = dictx[S[left]]
        else:
            for j in range(left,right):
                if dictx[S[j]] < min:
                    min = dictx[S[j]]
            result[i] = min
    return result
solution 2:
def compare2(x,y):
    if x <= y:
        return x
    else:
        return y
def compare3(x,y,z):
    if x <= y and x <= z:
        return x
    elif y <=x and y <= z:
        return y
    elif z <=x and z <= y:
        return z
def solution(S, P, Q):
    # write your code in Python 3.6
   
    sarray = [0 for x in range(len(S))]
    for x in range(len(S)):
        if S[x] == 'A':
            sarray[x]=1
        elif S[x] == 'C':
            sarray[x]=2
        elif S[x] == 'G':
            sarray[x]=3
        else:
            sarray[x]=4
    min2array = [0 for x in range(len(sarray))]
    min3array = [0 for x in range(len(sarray))]
    for x in range(len(sarray)-1):
        y = x + 1
        min2array[x] = compare2(sarray[x],sarray[y])
    for x in range(len(sarray)-2):
        y = x + 1
        z = x + 2
        min3array[x] =  compare3(sarray[x],sarray[y],sarray[z])
    min = 4
    M = 3
    minarray = [0 for x in range(M)]
    for x in range(M):
        if Q[x] == P[x]:
            minarray[x] = sarray[Q[x]]
        elif (Q[x] -P[x]) % 2 == 0:
            for y in range(P[x],Q[x],2):
                    if min2array[y] < min:
                        min = min2array[y]
            minarray[x] = min
        elif (Q[x] -P[x]) % 3 == 0:
            for y in range(P[x],Q[x],3):
                    if min3array[y] < min:
                        min = min3array[y]
            minarray[x] = min
        else:    
            num2 = math.floor((Q[x] - P[x])/2)
            pos = (num2 - 1) * 2
            for y in range(P[x],P[x]+pos,2):
                if min2array[y] < min:
                        min = min2array[y]
            if min3array[pos+1] < min:
                min = min3array[pos+1]
            minarray[x] = min
    return minarray
```
**
