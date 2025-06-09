---
layout: post
title: "Terraform write-only arguments"
date: 2025-04-11 15:25:06
description: terraform write-only
tags:
 - terraform
---

# Do not store the data in state.tf file in a plain text
[refer](https://developer.hashicorp.com/terraform/language/resources/ephemeral/write-only)
Need to bump the version number to tell terraform it needs to update the value

```
resource "aws_db_instance" "test" {
  instance_class      = "db.t3.micro"
  allocated_storage   = "5"
  engine              = "postgres"
  username            = "example"
  skip_final_snapshot = true
  password_wo         = <ephemeral or non-ephemeral value>
  password_wo_version = 1
}
```

