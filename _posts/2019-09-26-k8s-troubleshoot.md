---
layout: post
title: "K8s troubleshoot(WIP)"
date: 2019-09-26 19:25:06
description: Kubernetes troubleshoot
tags:
 - cloud
---

**Nodes**
- inidivdual node shuts down
pods on that node stop running
- Node Problem Detector(DaemonSet)
Collects node problems from daemons and reports them to the apiserver as NodeCondition and Event

**Network**
- network partition
partition A thinks the nodes in partiion B are down;partition B thinks the apiserver is down

**Apiserver**
- server shutdown
unable to stop, update, or start new pods, services, replication controller, existing pods and services should continue to work normally, unless they depend on the Kubernetes API
- apiserver backing storage lost
apiserver should fail to come up
kubelets will not be able to reach it but will continue to run the same pods and provide the same service proxying
manual recovery or recreation of apiserver state necessary before apiserver is restarted
- kubectl get cs

**Supporting services**
node controller, replication controller manager, scheduler, etc , it would be like apiserver

**kubelet**
- software fault
crashing kubelet cannot start new pods on the node
kubelet might delete the pods or not
node marked unhealthy
replication controllers start new pods elsewhere

**kube-proxy**


**Logs**
- Master
/var/log/kube-apiserver.log - API Server, responsible for serving the API
/var/log/kube-scheduler.log - Scheduler, responsible for making scheduling decisions
/var/log/kube-controller-manager.log - Controller that manages replication controllers
- Worker Nodes
/var/log/kubelet.log - Kubelet, responsible for running containers on the node
/var/log/kube-proxy.log - Kube Proxy, responsible for service load balancing


**Troulbeshoot**
```
Internet -- LB -- k8s ingress -- k8s service -- k8s pods
```
- cluster
kubectl top

- ingress
[tracing through an ingress](https://managedkube.com/kubernetes/trace/ingress/service/port/not/matching/pod/k8sbot/2019/02/13/trace-ingress.html)
[ingress and traffic flow](https://medium.com/@ManagedKube/kubernetes-troubleshooting-ingress-and-services-traffic-flows-547ea867b120)

- pods
terminationMessagePath

Pending: Generally this is because there are insufficient resources of one type or another that prevent scheduling. Look at the output of the kubectl describe ... 

Waiting: If a Pod is stuck in the Waiting state, then it has been scheduled to a worker node, but it can’t run on that machine. The most common cause of Waiting pods is a failure to pull the image. There are three things to check:

Crashing or unhealthy: 
kubectl logs ${POD_NAME} ${CONTAINER_NAME}
kubectl logs --previous ${POD_NAME} ${CONTAINER_NAME}
kubectl exec ${POD_NAME} -c ${CONTAINER_NAME} -- ${CMD} ${ARG1} ${ARG2} ... ${ARGN}

Pod is running without doing what I told it to do:
kubectl apply --validate -f mypod.yaml

- replication controllers
kubectl describe rc ${CONTROLLER_NAME}

- services
Services provide load balancing across a set of pods.
kubectl get endpoints ${SERVICE_NAME}

- traffic is not forwarded
If you can connect to the service, but the connection is immediately dropped, and there are endpoints in the endpoints list, it’s likely that the proxy can’t contact your pods.
Are your pods working correctly? Look for restart count, and debug pods.
Can you connect to your pods directly? Get the IP address for the Pod, and try to connect directly to that IP.
Is your application serving on the port that you configured? Kubernetes doesn’t do port remapping, so if your application serves on 8080, the containerPort field needs to be 8080.


- containers
 - nsenter
 - container_id: hash 
docker container ls -f name=logger -aq --no-trunc
ls /var/lib/docker/containers/[hash]
Docker captures the stdout and stderr streams from detached containers and forwards them to the configured logging driver.

ctr containers - manage containers

 - docker events
docker events --filter 'event=stop'

- network connection
```
kubectl get pods -o wide
kubectl port-forward NAME 8800 &
curl localhost:8080
```
```
PID=$(docker inspect --format '{{ .State.Pid }}' ContainerID)
nsenter -t ${PID} -n ip addr/ping/curl/nslookup
```
```
kubectl exec -it POD -- ping -c 2 $ip
```
```
sudo conntrack -L | grep $ip
```

- others
[k8s failure stories](https://k8s.af)
