---
layout: post
title: "Terraform destroy"
date: 2025-03-10 10:25:06
description: terraform init, destroy, cleanup 
tags:
 - terraform
---

In CI/CD pipeline, we can use tftest.TerraformTest for testing terraform code and use tf.destroy in case any errors/finally cleanup. But sometimes destroy stage would fail due to timeout or other reasons, leave the state in a broken state. For this case, we can try to init a cleanup step by
```
terraform init -backend-config=bucket=xxx -backend-config=key=xxx -backend-config=region=xxx # with an empty main.tf
terraform destroy -auto-approve
```
