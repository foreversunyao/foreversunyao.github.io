---
layout: post
title: "docker troubleshoot"
date: 2021-02-26 19:25:06
description: docker troubleshoot
tags:
 - k8s
---

## large disk usage
1. find large log and remove
```
$ for name in $(docker ps -a  | awk '{print $1}' | grep -v CONTAINER); do docker inspect $name | grep LogPath | awk '{print $NF}' | tr -d '",' |xargs du -sh;done
```
2. tune log config at /etc/docker/daemon.json

3. remove unused images, like <none> intermediate images, unused and not reference as well
```
for images_id_1 in `docker images  | awk '$2 ~ "<none>"{print $3}'`
do
    docker rmi $images_id_1
done
```

4. garbage collection by kubelet
```
HighThresholdPercent, tigger garbage collection
LowThresholdPercent, stop garbage collection till 
```
