---
layout: post
title: "K8s troubleshoot"
date: 2021-09-26 19:25:06
description: Kubernetes troubleshoot
tags:
 - k8s
---
**troubleshooting-graph**
[refer](https://learnk8s.io/a/troubleshooting-kubernetes.pdf)
- error code 

```
kubernetes:
    node:
      - TerminatedAllPods       # Terminated All Pods      (information)
      - RegisteredNode          # Node Registered          (information)*
      - RemovingNode            # Removing Node            (information)*
      - DeletingNode            # Deleting Node            (information)*
      - DeletingAllPods         # Deleting All Pods        (information)
      - TerminatingEvictedPod   # Terminating Evicted Pod  (information)*
      - NodeReady               # Node Ready               (information)*
      - NodeNotReady            # Node not Ready           (information)*
      - NodeSchedulable         # Node is Schedulable      (information)*
      - NodeNotSchedulable      # Node is not Schedulable  (information)*
      - CIDRNotAvailable        # CIDR not Available       (information)*
      - CIDRAssignmentFailed    # CIDR Assignment Failed   (information)*
      - Starting                # Starting Kubelet         (information)*
      - KubeletSetupFailed      # Kubelet Setup Failed     (warning)*
      - FailedMount             # Volume Mount Failed      (warning)*
      - NodeSelectorMismatching # Node Selector Mismatch   (warning)*
      - InsufficientFreeCPU     # Insufficient Free CPU    (warning)*
      - InsufficientFreeMemory  # Insufficient Free Mem    (warning)*
      - OutOfDisk               # Out of Disk              (information)*
      - HostNetworkNotSupported # Host Ntw not Supported   (warning)*
      - NilShaper               # Undefined Shaper         (warning)*
      - Rebooted                # Node Rebooted            (warning)*
      - NodeHasSufficientDisk   # Node Has Sufficient Disk (information)*
      - NodeOutOfDisk           # Node Out of Disk Space   (information)*
      - InvalidDiskCapacity     # Invalid Disk Capacity    (warning)*
      - FreeDiskSpaceFailed     # Free Disk Space Failed   (warning)*
    pod:
      - Pulling           # Pulling Container Image          (information)
      - Pulled            # Ctr Img Pulled                   (information)
      - Failed            # Ctr Img Pull/Create/Start Fail   (warning)*
      - InspectFailed     # Ctr Img Inspect Failed           (warning)*
      - ErrImageNeverPull # Ctr Img NeverPull Policy Violate (warning)*
      - BackOff           # Back Off Ctr Start, Image Pull   (warning)
      - Created           # Container Created                (information)
      - Started           # Container Started                (information)
      - Killing           # Killing Container                (information)*
      - Unhealthy         # Container Unhealthy              (warning)
      - FailedSync        # Pod Sync Failed                  (warning)
      - FailedValidation  # Failed Pod Config Validation     (warning)
      - OutOfDisk         # Out of Disk                      (information)*
      - HostPortConflict  # Host/Port Conflict               (warning)*
    replicationController:
      - SuccessfulCreate    # Pod Created        (information)*
      - FailedCreate        # Pod Create Failed  (warning)*
      - SuccessfulDelete    # Pod Deleted        (information)*
      - FailedDelete        # Pod Delete Failed  (warning)*
```
**Nodes**
- inidivdual node shuts down
pods on that node stop running
- Node Problem Detector(DaemonSet)
Collects node problems from daemons and reports them to the apiserver as NodeCondition and Event

**Network**
- network partition
partition A thinks the nodes in partiion B are down;partition B thinks the apiserver is down
- IP Address Shortage
[refer](https://medium.com/compass-true-north/experiences-for-ip-addresses-shortage-on-eks-clusters-a740f56ac2f5)

```
/var/log/aws-routed-eni/ipamd.log
``` 

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
service -> pods

**volume**
- detach
```
kubectl get volumeattachment
kubectl get pvc
kubectl describe pv <> # find volume ID from 'VolumeHandle' tag
kubectl patch pvc data00-# -p '{"metadata":{"finalizers":null}}'
```
- expand
[expand pv](https://serverfault.com/questions/955293/how-to-increase-disk-size-in-a-stateful-set)

- missing pvc, reuse pv by new pvc
[refer](https://webera.blog/recreate-an-existing-pvc-in-a-new-namespace-but-reusing-the-same-pv-without-data-loss-2c7326c0035a)
[refer2](https://docs.avisi.cloud/docs/runbooks/claim-existing-pv-with-pvc/)

- volume snapshots
[volume snapshot](https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/examples/kubernetes/snapshot/README.md)



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

- k8s scheduling
1. FailedScheduling
```
0/200 nodes are available -> 200 nodes in total
90 has taint XXX -> pods cannot tolerate
50 did not match Pod's node affinity/selector -> affinity/selector
40 unschedulable -> unschedulable
10 had insufficient memeory
1 had in sufficient cpu
9 had volume node affinity conflict
```
- ingress
[tracing through an ingress](https://managedkube.com/kubernetes/trace/ingress/service/port/not/matching/pod/k8sbot/2019/02/13/trace-ingress.html)
[ingress and traffic flow](https://medium.com/@ManagedKube/kubernetes-troubleshooting-ingress-and-services-traffic-flows-547ea867b120)

- pods
1. terminationMessagePath

Pending: Generally this is because there are insufficient resources of one type or another that prevent scheduling. Look at the output of the kubectl describe ... 

Waiting: If a Pod is stuck in the Waiting state, then it has been scheduled to a worker node, but it can’t run on that machine. The most common cause of Waiting pods is a failure to pull the image. There are three things to check:

2. Crashing or unhealthy: 
kubectl logs ${POD_NAME} ${CONTAINER_NAME}
kubectl logs --previous ${POD_NAME} ${CONTAINER_NAME}
kubectl exec ${POD_NAME} -c ${CONTAINER_NAME} -- ${CMD} ${ARG1} ${ARG2} ... ${ARGN}

3. CrashLoopBackOff
[refer](https://sysdig.com/blog/debug-kubernetes-crashloopbackoff/)
[refer2](https://containersolutions.github.io/runbooks/posts/kubernetes/crashloopbackoff/)
```
Gather information
Examine Events section in describe output
Check the exit code
Check readiness/liveness probes
Check common application issues
```

4. Pod is running without doing what I told it to do:
kubectl apply --validate -f mypod.yaml

```
1. Pending, object was created and stored in etcd, but failed to be scheduled. resource not enough? cpu/mem/gpu,hostport..
2. Waiting or ContainerCreating, image pull failed/cni failure/failed create pod sanbox, input/out error
4. ImagePullBackOff, pull failed
5. CrashLoopBackOff, started and crash/exit again --> kubectl logs --previous/kubelet and container logs on Node
6. Error, failed at starting, like cm, secret,pv, limitrange, securitypolicy,rbac
7. Terminating or Unknow, the node pod is running on  cant be reachable 
8. InvalidImageName
9. ImageInspectError, verify image failed
10. ErrImageNeverPull
11. ErrImagePull
12. CreateContainerConfigError
13. CreateContainerError
14. m.internalLifecycle.PreStartContainer
15. RunContainerError
16. PostStartHookError
17. ContainersNotInitialized
18. ContainersNotReady
19. ContainerCreating
20. PodInitializing
21. DockerDaemonNotReady
22. NetworkPluginNotReady
```

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
docker ps |grep pod-name
PID=$(docker inspect --format '{{ .State.Pid }}' ContainerID)
nsenter -t ${PID} -n ip addr/ping/curl/nslookup/dig
```
```
kubectl exec -it POD -- ping -c 2 $ip
```
```
sudo conntrack -L | grep $ip
```
- pod exit code
```
0: successfully exit, like job
1: programe failure
137: SIGKILL, kill-9 or OOM
139: code problem, SIGSEGV
143: SIGTERM, docker stop
126: permission or cant execute
127: shell script failure
1 or 255
```

- memory request, oom
[refer](https://medium.com/@betz.mark/understanding-resource-limits-in-kubernetes-memory-6b41e9a955f9)
```
$ docker ps | grep busy | cut -d' ' -f1
8fec6c7b6119
$ docker inspect 8fec6c7b6119 --format '{{.HostConfig.Memory}}'
104857600
$ ps ax | grep /bin/sh
   29532 ?      Ss     0:00 /bin/sh -c while true; do sleep 2; done
$ sudo cat /proc/29532/cgroup
...
6:memory:/kubepods/burstable/pod88f89108-daf7-11e8-b1e1-42010a800070/8fec6c7b61190e74cd9f88286181dd5fa3bbf9cf33c947574eb61462bc254d11
$ sudo cat /sys/fs/cgroup/memory/kubepods/burstable/pod88f89108-daf7-11e8-b1e1-42010a800070/8fec6c7b61190e74cd9f88286181dd5fa3bbf9cf33c947574eb61462bc254d11/memory.limit_in_bytes
104857600
```
- cpu request and limit, throttling
[refer](https://medium.com/@betz.mark/understanding-resource-limits-in-kubernetes-cpu-time-9eff74d3161b)
```
100m
quota
period
```

- others
[k8s failure stories](https://k8s.af)
[faq](https://wener.me/notes/devops/kubernetes/k8s-faq/)
