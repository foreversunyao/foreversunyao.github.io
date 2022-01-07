---
layout: post
title: "basic data structure and algorithms"
date: 2019-12-24 10:50:06
description: algorithms, data structure, time complexity
tags: 
 - code
---

## what is algorithm
a few logical steps to solve specific calculate problem
## what is data structure
a way to organise, manage and store data, which make it can be accessed and modified effectively
## the ways to evaluate algorithm
1. time complexity
basic operation times
O(1)
O(logN)
O(n)
O(nlogN)
O(n^2)
2. space complexity
mem used for store temporary data
O(1) constant, no relation with input size
O(n), Linear
O(n^2),
recursion -> O(depth of recursion)

## basic data structure
array and linked list are physical structures; stack,queue,tree,graph are logical structures
1. array
- retrieve element by index in O(1) time
- insert/delete need to move elements in O(n) time
- O(n) space complexity
2. linked list
- not consecutive on space
- each node has two parts(data and next pointer)
- tail node's next pointer is NULL
- retrieve node one by one, O(n) time
- only insert/delete operation takes O(1) time
3. stack
- bottom and top, Fisrt In Last Out.
- push, pop
- O(1)
4. queue
- front and rear, First In First Out
- enqueue and dequeue
- if( (rear+1)%array.length == front ), queue is full
- if(rear==front) , queue is empty
- Oi(1)
5. double ended queue
- allows insertion and removal of elements from both the ends.
- push_front,push_back,pop_front,pop_back
6. Priority queue
- it's not a typical queue, it's implemented by heap
7. hash table
- key and value
- implement by array
- index = HashCode(Key) % Array.length
- put, if conflict use list
- get, if not follow the list to check 
- resize, create a new array with larger size, re-Hash current entry and put to new array
8. tree
- only one root and its children is also a tree 
- parent, child, sibling
- binary tree has at most 2 children per node, full binary tree vs complete binary
- it can have two physical structures, linked list(data,left,right) and array(level traverse, array[parent], left is array[2 * parent+1] right is array[2 * parent +2]) 
- binary search tree -> O(logN)
- traverse DFS(preorder,inorder,postorder) and BFS(level)
- priority queue is implemented by max heap and min heap 
- basic operations: search, insert O(logN), delete O(logN), build O(n)
9. sort
