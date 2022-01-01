---
layout: post
title: "Linux storage"
date: 2019-09-22 21:25:06
description: object storage, file storage, block storage
tags:
 - linux
---
## object storage
- Object storage, also known as object-based storage, is a flat structure in which files are broken into pieces and spread out among hardware. In object storage, the data is broken into discrete units called objects and is kept in a single repository, instead of being kept as files in folders or as blocks on servers.
- Data, identifier and metadata
- Object storage volumes work as modular units: each is a self-contained repository that owns the data, a unique identifier that allows the object to be found over a distributed system, and the metadata that describes the data. That metadata is important and includes details like age, privacies/securities, and access contingencies.
- pros
```
it enables the storage of massive amounts of unstructured data while still maintaining easy data accessibility.
infinite scalability
```
- cons:
```
Objects can’t be modified—you have to write the object completely at once.
```
- use cases
1. unstructured data like multimedia files
2. large data sets

## file storage
- File storage, also called file-level or file-based storage, is exactly what you think it might be: Data is stored as a single piece of information inside a folder
- To access a file, users or machines only need the path from directory to subdirectory to folder to file.
- pros
1. easy to share
2. fast to navigate
- cons
1. not easy to expand storage, limitation on hierachy and permissions
- use cases
1. store files for directory
2. Storage of data that requires data protection and easy deployment

## block storage
- data is broken up into pieces called blocks, and then stored across a system that can be physically distributed to maximize efficiency. Each block receives a unique identifier, which allows the storage system to put the blocks back together when the data they contain are needed.
- when data is requested, the underlying storage software reassembles the blocks of data from these environments and presents them back to the user. 
- pros
1. quickly retrieve and manipulate data
2. decouple data
- cons
1. expensive
2. limited capability to handle metadata, need rely on application or database level
- use cases
1. storage of databases
2. cricital system data 


[refer](https://www.backblaze.com/blog/object-file-block-storage-guide/)
