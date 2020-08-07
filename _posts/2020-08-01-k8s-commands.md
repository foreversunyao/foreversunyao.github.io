---
layout: post
title: "K8s command"
date: 2020-08-01 02:25:06
description: command
tags:
 - k8s

- kubectl get pods
A Pod is Running when it has successfully attached to a node and
all of its containers have been created. Containers inside a Pod can
be starting, restarting, or running continuously.
Succeeded means that all containers have finished running
successfully. In other words, they’ve terminated successfully and
they won’t be restarting.
Failed means a container has terminated with a failure, and it won’t
be restarting.
Unknown is where the state of the Pod simply cannot be retrieved,
probably because of a communication error between the master
and a kubelet. It’s not a commonly seen state.
CrashLoopBackOff means that one of the containers in the Pod
exited unexpectedly even after it was restarted at least once. This
is a common error. Usually, CrashLoopBackOff means that the Pod
isn’t configured correctly.
