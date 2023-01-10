---
layout: post
title: "Docker image"
date: 2021-03-01 17:25:06
description: dive, Docker, image
tags: 
 - linux
---
[refer](https://www.howtogeek.com/devops/how-to-inspect-a-docker-images-content-without-starting-a-container/)


# create container without starting
docker create --name suspect-container suspect-image:latest

# exporting container's filesystem
docker export suspect-container > suspect-container.tar

# transport image
docker image save suspect-image:latest > suspect-image.tar

# listing layers
docker image history suspect-image:latest

# fs
ls -l /var/lib/docker/overlay2

# dive
[refer](https://github.com/wagoodman/dive)



