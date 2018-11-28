---
layout: post
title: "Codility EquiLeader"
date: 2017-10-21 08:25:06
description: Algorithm (Need to improve)
tags:
 - code
---


**1. EquiLeader**
```
# you can write to stdout for debugging purposes, e.g.
# print("this is a debug message")


"""
1, demo
4 3 4 4 4 2
2, simple logic
for loop
find the leaders in two groups, and compare them if they are equal
3, bad performance due to repeatly do some tasks
if use dict to record the key and how many times it appears
and max in two groups
"""

def solution(A):
    # write your code in Python 3.6
    if len(A) ==1:
        return 0
    elif len(A) ==2:
        if A[0] != A[1]:
            return 0
        else:
            return 1
    else:
        flag = 0
        leaderLeft = None
        leaderRight = None
        dictLeft = {}
        dictRight = {}
        count = 0
        for i in range(0,len(A)):
            if A[i] in dictRight:
                dictRight[A[i]] = dictRight[A[i]] + 1
                if dictRight[A[i]] > (len(A))/2:
                    leaderRight = A[i]
            else:
                dictRight[A[i]] = 1
        ##print(dictRight)
        for i in range(len(A)):
            print(dictLeft)
            print(dictRight)
            print("-")
            print(leaderLeft)
            print(leaderRight)
            print("====")
            if leaderLeft is not None and leaderRight is not None and leaderLeft == leaderRight:
                count = count + 1
            if A[i] in dictLeft:
                dictLeft[A[i]] = dictLeft[A[i]] + 1
                if dictLeft[A[i]] > (i+1) / 2:
                    leaderLeft = A[i]
                if dictLeft[leaderLeft] <= (i+1) / 2:
                    leaderLeft = None
            else:
                dictLeft[A[i]] = 1
                if dictLeft[A[i]] > (i+1) / 2:
                    leaderLeft = A[i]
                else:
                    leaderLeft = None
            if A[i] in dictRight:
                dictRight[A[i]] = dictRight[A[i]] - 1
                if dictRight[A[i]] == 0:
                    dictRight.pop(A[i])
                if A[i] in dictRight and dictRight[A[i]] > (len(A) -i -1 )/2:
                        leaderRight = A[i]
                else:
                    for k,v in dictRight.items():
                        if v > (len(A) -i -1 )/2:
                            leaderRight =  k
                            break
                        else:
                            leaderRight = None
        return count
```
