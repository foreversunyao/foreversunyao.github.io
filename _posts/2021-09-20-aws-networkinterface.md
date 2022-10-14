---
layout: post
title: "AWS Network interface basics"
date: 2021-09-20 10:25:06
description: aws, network interface, primary ipv4, elastic ip, public ip 
tags:
 - cloud
---
[refer](https://github.com/aws/amazon-vpc-cni-k8s/blob/master/docs/eni-and-ip-target.md)

## Elastic network interfaces
An elastic network interface is a logical networking component in a VPC that represents a virtual network card.

- primary network interface
Each instance has a default network interface, called the primary network interface. You cannot detach a primary network interface from an instance. You can create and attach additional network interfaces.
The maximum number of network interfaces that you can use varies by instance type.
- elastic ip addresses for network interface
You can associate one Elastic IP address with each private IPv4 address.

## Network cards
Instances with multiple network cards provide higher network performance, including bandwidth capabilities above 100 Gbps and improved packet rate performance. Each network interface is attached to a network card. The primary network interface must be assigned to network card index 0.

## IP addresses per network interface per instance type
such as c5d.24xlarge, max network interfaces is 15, and private ipv4 per interface is 50, ipv6 address per interface is 50
```
aws ec2 describe-instance-types --filters "Name=instance-type,Values=c5.*" --query "InstanceTypes[].{Type: InstanceType, MaxENI: NetworkInfo.MaximumNetworkInterfaces, IPv4addr: NetworkInfo.Ipv4AddressesPerInterface}" --output table
---------------------------------------
|        DescribeInstanceTypes        |
+----------+----------+---------------+
| IPv4addr | MaxENI   |     Type      |
+----------+----------+---------------+
|  30      |  8       |  c5.4xlarge   |
|  50      |  15      |  c5.24xlarge  |
|  15      |  4       |  c5.xlarge    |
|  30      |  8       |  c5.12xlarge  |
|  10      |  3       |  c5.large     |
|  15      |  4       |  c5.2xlarge   |
|  50      |  15      |  c5.metal     |
|  30      |  8       |  c5.9xlarge   |
|  50      |  15      |  c5.18xlarge  |
+----------+----------+---------------+
```
