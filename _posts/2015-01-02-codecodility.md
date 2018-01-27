---
layout: post
title: "Codility TapeEquilibrium/FrogJmp/PermMissingElem"
date: 2015-01-02 12:25:06
description: Algorithm
tags:
 - code
---


** 1. TapeEquilibrium **

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
    

** 2. FrogJmp **



** 3. PermMissingElem **


