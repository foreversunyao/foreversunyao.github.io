---
layout: post
title: "Terraform dependency"
date: 2024-10-09 12:25:06
description: Terraform dependency, implicit dependency, explicit dependency, depends_on
tags:
 - terraform
---

**Dependencies in terraform**
In Terraform, dependencies represent the relationships between resources, indicating which resources depend on the creation or modification of others. 

Two ways:
- implicit
by referencing attributes from one resource 
```
resource “aws_security_group” “web_sg” {
security_group_ids = [aws_instance.web.security_group_ids[0]]
}
```

- explicit
by using depends_on attribute winthin a resource block
```
resource “aws_security_group” “web_sg” {
depends_on = [aws_instance.web]
}
```

Dependencies are not limited to just resources, can be created between modules.

**Pros and Cons**
Terraform builds a directed acyclic graph (DAG) based on these dependencies, where each node represents a resource, and edges represent dependencies between them. During the terraform apply process, Terraform traverses this graph, creating or modifying resources in the appropriate order to satisfy their dependencies.

- Pros:
Resources are provisioned or modified in the required order

- Cons:
depends_on causes Terraform to create a more conservative plan. The plan may modify more resources than necessary. For example, there may be more values as unknown “(known after apply)”. This is more likely to occur when creating explicit dependencies between modules.

Adding explicit dependencies can increase the length of time it takes to build your infrastructure because Terraform must wait until the dependency object is created before continuing.


**Last**
It is recommended to use expression references to create implicit dependencies whenever possible.

[reference](https://dev.to/pdelcogliano/how-to-use-terraform-dependson-3a0k)
