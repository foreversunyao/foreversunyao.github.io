---
layout: post
title: "AWS VPC"
date: 2021-10-17 10:25:06
description: aws, kubernetes,  Athena, visibility, traffic mirroring, cloudwatch
tags:
 - cloud
---

[refer](https://aws.amazon.com/blogs/networking-and-content-delivery/using-vpc-flow-logs-to-capture-and-query-eks-network-communications/)
- Athena
Amazon Athena makes it easy to analyze data in Amazon S3 using standard SQL. 

- kubernetes networking patterns

Pod to Pod
Pod to ClusterIP
Node to Pod
Node to ClusterIP
Load balancer / NodePort

- VPC flow logs

- VPC Traffic mirroring
[refer](https://aws.amazon.com/blogs/networking-and-content-delivery/mirror-production-traffic-to-test-environment-with-vpc-traffic-mirroring/)
Traffic Mirroring is an Amazon VPC feature that you can use to copy network traffic from an elastic network interface of Amazon EC2 instances. You can then send the traffic to out-of-band security and monitoring appliances for:
Content inspection
Threat monitoring
Troubleshooting

- cloudwatch agent on ec2
[refer](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Install-CloudWatch-Agent.html)
This will capture OS level metrics, give you access to statsD/collectD protocols, and allow you to capture custom metrics at an instance level if needed

- capture of pod level logs
[refer](https://aws.amazon.com/blogs/containers/how-to-capture-application-logs-when-using-amazon-eks-on-aws-fargate/)
The demo container produces logs to /var/log/containers/application.log. Fluentd is configured to watch /var/log/containers and send log events to CloudWatch. The pod also runs a logrotate sidecar container that ensures the container logs don’t deplete the disk space. In the example, cron triggers logrotate every 15 minutes; you can customize the logrotate behavior using environment variables

- tcpdump within pods
```
> kubectl get pod mypod -o json #grab the containerID field
> docker exec <containerID> /bin/bash -c 'cat <main container interface, e.g., /sys/class/net/eth0/iflink>' #grab interface number
> ip link |grep ^13 #should return veth in format vethXXXXX format
> tcpdump -i vethXXXXX
```.
