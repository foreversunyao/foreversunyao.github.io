---
layout: post
title: "Terraform Features"
date: 2023-11-10 12:25:06
description: Terraform useful features 
tags:
 - cloud
---

**Moved Block**
Starting from v1.1, Terraform provides a powerful feature known as the moved block. This feature allows you to reorganize your Terraform configuration without causing Terraform to perceive the refactor as a deletion and creation of resources.
[refer](https://tanmay-bhat.github.io/posts/how-to-move-a-terraform-resource-into-a-module-using-moved-block/)
```
module "s3" {
  source = "./modules/aws/s3"
}

moved {
  from = aws_s3_bucket.moved_demo
  to   = module.s3.aws_s3_bucket.moved_demo
}
```

**Dynamic blocks**
Dynamic blocks within Terraform take this concept a step deeper. Their purpose is to create multiple similar elements within a resource. 
```
# Security Groups
resource "aws_security_group" "sg-webserver" {
    vpc_id              = aws_vpc.vpc.id
    name                = "webserver"
    description         = "Security Group for Web Servers"
    ingress {
        protocol = "tcp"
        from_port = 80
        to_port = 80
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    ingress {
        protocol = "tcp"
        from_port = 443
        to_port = 443
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    egress {
        protocol = "tcp"
        from_port = 443
        to_port = 443
        cidr_blocks = [ var.vpc-cidr ]
    }
    egress {
        protocol = "tcp"
        from_port = 1433
        to_port = 1433
        cidr_blocks = [ var.vpc-cidr ]
    }
}

locals {
    inbound_ports = [80, 443]
    outbound_ports = [443, 1433]
}

# Security Groups
resource "aws_security_group" "sg-webserver" {
    vpc_id              = aws_vpc.vpc.id
    name                = "webserver"
    description         = "Security Group for Web Servers"

    dynamic "ingress" {
        for_each = local.inbound_ports
        content {
            from_port   = ingress.value
            to_port     = ingress.value
            protocol    = "tcp"
            cidr_blocks = [ "0.0.0.0/0" ]
        }
    }

    dynamic "egress" {
        for_each = local.outbound_ports
        content {
            from_port   = egress.value
            to_port     = egress.value
            protocol    = "tcp"
            cidr_blocks = [ var.vpc-cidr ]
        }
    }
}
```
