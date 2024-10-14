---
layout: post
title: "Terraform Features"
date: 2023-11-10 12:25:06
description: Terraform useful features 
tags:
 - terraform
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

**count,for_each and for loops**
- count
access object by index in the sequence 
```
variable "projects" {
  type        = list(string)
  default     = ["test-project-1", "test-project-2", "test-project-3"]
}

resource "aws_s3_bucket" "bucket" {
  count = length(var.projects)

  bucket = "bucket-${var.projects[count.index]}"
}

output "bucket_names" {
  value       = aws_s3_bucket.bucket[*].id 
}
```
- for_each
iterate map/set by using each key and value instead of index
```
variable "projects" {
  type  = map(map(string))
  default = {
    "test-project-1" = {
      tag_name = "Test Project 1", object_lock_enabled = true 
    },
    "test-project-2" = {
      tag_name = "Test Project 2", object_lock_enabled = false
    },
    "test-project-3" = {
      tag_name = "Test Project 3", object_lock_enabled = false
    }
  }
}

variable "common_tags" {
  type    = map(string)
  default = {
    "Team"      = "devops",
    "CreatedBy" = "terraform"
  }
}

resource "aws_s3_bucket" "bucket" {
  for_each  = var.projects

  bucket   = "bucket-${each.key}"
  object_lock_enabled = each.value.object_lock_enabled
  tags  = merge(var.common_tags, {Name = each.value.tag_name})
}
```
- for
filtering and transformation operations on variable values.
```
output "bucket_names" {
  value       = [for a in values(aws_s3_bucket.bucket)[*].id : upper(a)]
}
variable "common_tags" {
  type    = map(string)
  default = {
    "Team"      = "devops",
    "CreatedBy" = "terraform"
  }
}

output "common_tags" {
  value       = [for a, b in var.common_tags : "Key: ${a} value: ${b}" ]
}

```


**map object**
```
output "bucket_names" {
  value       = values(aws_s3_bucket.bucket)[*].id 
}
```

[reference](https://itnext.io/terraform-count-for-each-and-for-loops-1018526c2047)
