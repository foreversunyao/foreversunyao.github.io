---
layout: post
title: "K8s control plane node maintenance"
date: 2020-10-11 14:25:06
description: control plane node
tags:
 - k8s

**How to rebuild kube-ctl nodes**
- backup all old configs(certs/keys/configs)
- drain pods on kube-ctl if any
- on kube-ctl run 
```
kubeadm reset phase remove-etcd-member
kubeadm reset
```
- login etcd container to check if this member has been removed 
```
sudo docker exec -it $(sudo docker ps -f name=etcd_etcd -q) /bin/sh
etcdctl --endpoints https://127.0.0.1:2379 --ca-file /etc/kubernetes/pki/etcd/ca.crt --cert-file /etc/kubernetes/pki/etcd/server.crt --key-file /etc/kubernetes/pki/etcd/server.key member list
```
- if it's still there, remove it by command
```
etcdctl --endpoints https://127.0.0.1:2379 --ca-file
/etc/kubernetes/pki/etcd/ca.crt --cert-file /etc/kubernetes/pki/etcd/server.crt --key-file /etc/kubernetes/pki/etcd/server.key remove <id>
```
- reinstall kube-ctl
- remove vip before join , or hit connection refused
- generate join command
```
# basic command , run on another kube-ctl node
sudo kubeadm token create --ttl 10m —print-join-command
# get cert key , run on another kube-ctl node
sudo kubeadm init phase upload-certs  --upload-certs
# join as control node
sudo kubeadm join kube-api:6443 --node-name DDD --token AAA --discovery-token-ca-cert-hash sha256:CCC --control-plane --certificate-key BBB --v=5
```
- add vip back and validate`
