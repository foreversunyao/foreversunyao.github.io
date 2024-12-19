---
layout: post
title: "Terraform security"
date: 2024-11-25 12:25:06
description: terraform, state, secret, security, trivy 
tags:
 - terraform
---
[refer](https://www.hashicorp.com/blog/terraform-1-10-improves-handling-secrets-in-state-with-ephemeral-values)

# Terraform state
private keys, certifications, API tokens get persisted in the plain or state file.

# Ephemeral values
These values are not stored in any artifact. Not the plan file or the statefile. They are not expected to remain consistent from plan to apply, or from one plan/apply round to the next.

- Ephemeral input variables and output variables: Similar to marking a value as sensitive, you can now mark the input variables and output variables as ephemeral. Marking an input variable as ephemeral is useful for data that only needs to exist temporarily, such as a short-lived token or session identifier.
- Ephemeral resources: A new third resource mode alongside managed resource types and data resources. These are declared with ephemeral blocks, which declare that something needs to be created or fetched separately for each Terraform phase, then used to configure some other ephemeral object, and then explicitly closed before the end of the phase.
- Managed resources’ write-only attribute: A new attribute for managed resources, which has a property that can only be written to, not read. Write-only attributes will be available in Terraform 1.11.

Ephemeral values represent an advancement in how Terraform helps you manage your infrastructure. Whether you are using it to generate credentials, fetch a token, or setting up a temporary network tunnel, ephemeral values will ensure that these values are not persisted in Terraform artifacts.


# Example
```
provider "aws" {
  region = "eu-west-2"
}
 
data "aws_db_instance" "example" {
  db_instance_identifier = "testdbinstance"
}
 
ephemeral "aws_secretsmanager_secret_version" "db_master" {
  secret_id = data.aws_db_instance.example.master_user_secret[0].secret_arn
}
 
locals {
  credentials = jsondecode(ephemeral.aws_secretsmanager_secret.db_master.secret_string)
}
 
provider "postgresql" {
  host     = data.aws_db_instance.example.address
  port     = data.aws_db_instance.example.port
  username = local.credentials["username"]
  password = local.credentials["password"]
}
 
resource "postgresql_database" "db" {
  name = "new_db"
}
```

# Trivy
[refer](https://trivy.dev/v0.46/tutorials/misconfiguration/terraform/)
```
trivy config <specify the directory> 
trivy fs --scanners secret,config ./
```
