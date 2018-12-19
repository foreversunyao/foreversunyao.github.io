---
layout: post
title: "Codility MaxProductOfThree"
date: 2016-02-21 08:25:06
description: Algorithm 
tags:
 - code
---


**1. MaxProductOfThree**
```
# you can write to stdout for debugging purposes, e.g.
# print("this is a debug message")

## Use space to reduce time complexity, due to what we need to get, we don't need to get all the results from the array, just TOP 3 for posistive and negative.

def solution(A):
    # write your code in Python 3.6
    if len(A) == 3:
        return A[0]*A[1]*A[2]
    else:
        pos_top = [-1]*3
        neg_top = [0]*3
        neg_max = [-1001]*3
    for i in range(len(A)):
        if A[i] > 0:
            if A[i] >= pos_top[0]:
                pos_top[2] = pos_top[1]
                pos_top[1] = pos_top[0]
                pos_top[0] = A[i]
            elif A[i] < pos_top[0] and A[i] >= pos_top[1]:
                pos_top[2]=pos_top[1]
                pos_top[1]=A[i]
            elif A[i]>pos_top[2]:
                pos_top[2]=A[i]
        else:
            if A[i] <= neg_top[0]:
                neg_top[2] = neg_top[1]
                neg_top[1] = neg_top[0]
                neg_top[0] = A[i]
            elif A[i] > neg_top[0] and A[i] <= neg_top[1]:
                neg_top[2]=neg_top[1]
                neg_top[1]=A[i]
            elif A[i]<neg_top[2]:
                neg_top[2]=A[i]
            else:
                pass
            if A[i] >= neg_max[0]:
                neg_max[2] = neg_max[1]
                neg_max[1] = neg_max[0]
                neg_max[0] = A[i]
            elif A[i] < neg_max[0] and A[i] >= neg_max[1]:
                neg_max[2]=neg_max[1]
                neg_max[1]=A[i]
            elif A[i]>neg_max[2]:
                neg_max[2]=A[i]
            else:
                pass

    while -1 in pos_top:
        pos_top.remove(-1);
    while 0 in neg_top:
        neg_top.remove(0);
    while -1001 in neg_max:
        neg_max.remove(-1001);


    if len(pos_top)==3:
        if len(neg_top) >= 2:
            ## positive >=3 and neg >=2
            if pos_top[2] * pos_top[1] * pos_top[0] > pos_top[0] * neg_top[0] *neg_top[1]:
                return pos_top[2] * pos_top[1] * pos_top[0]
            else:
                return  pos_top[0] * neg_top[0] *neg_top[1]
        else:
            return pos_top[2] * pos_top[1] * pos_top[0]
    if len(pos_top) ==2:
            return pos_top[0] * neg_top[0] *neg_top[1]
    if len(pos_top) ==1:
            return pos_top[0] * neg_top[0] *neg_top[1]

    if len(pos_top) ==0:
            return neg_max[2] * neg_max[1] * neg_max[0]
```
