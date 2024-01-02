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
