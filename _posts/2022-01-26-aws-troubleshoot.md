---
layout: post
title: "AWS troubleshoot"
date: 2022-01-26 19:25:06
description: AWS troubleshoot
tags:
 - cloud
---


**EBS**
- volume node affinity conflict
1. happens when the persistent volume claims that the pods are using, are scheduled on different zones, rather than on one zone, and so the actual pod was not able to be scheduled because it cannot connect to the volume from another zone. 
2. Amazon EBS CSI driver is needed for eks 1.23 onward, [refer](https://support.codefresh.io/hc/en-us/articles/7510188292636-Volume-provisioning-issues-after-Kubernetes-upgrade-to-1-23-Amazon-EBS-CSI-driver-)                                                                    
```
aws eks describe-addon --cluster-name my-cluster --addon-name aws-ebs-csi-driver --query "addon.addonVersion" --output text
```
