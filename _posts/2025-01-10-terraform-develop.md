---
layout: post
title: "Terraform develop"
date: 2025-01-10 12:25:06
description: terraform develop, aws 
tags:
 - terraform
---

# data handling and conversion 
```
terraform AWS provider includes: Terrafom plugin and AWS API client
data handling and conversion is needed as one side is IaC tool, anothor side is AWS API details
Expanding: data is converted from a planned new tf state into making a remote system request 
Flattening: a remote system response is converted into an applied new tf state
```

The Terraform AWS Provider codebase bridges the implementation of a Terraform Plugin and an AWS API client to support AWS operations and data types as Terraform Resources. Data handling and conversion is a large portion of resource implementation given the domain-specific implementations of each side of the provider. The first is where Terraform is a generic infrastructure as code tool with a generic data model and the other is where the details are driven by AWS API data modeling concepts. 

# Terraform Core
1. reads HCL or json files; parse them into an internal data structure
2. state management; maintains and updates the tf state file(terraform.tfstate), track real-world resources and apply them
3. graph construction; builds a dependency graph for all resources, ensure resources are created, updated, or destroyed in the correct order
4. execution plan generation; compares desired state with current state, creates execution plan(terraform plan)
5. resource application: applies changes and interacts with tf providers
6. provider & plugin interation
7. change detection and drift management

# Terraform Plugins
providers + provisioners

![img]({{ '/assets/images/cloud/terraform_core_plugins.png' | relative_url }}){: .center-image }*(°0°)*

# Terraform plan execution
![img]({{ '/assets/images/cloud/terraform_plans.png' | relative_url }}){: .center-image }*(°0°)*

# Data handling when creating a tf resoruce
1. An operator creates a Terraform configuration with a new resource defined and runs terraform apply
2. Terraform CLI merges an empty prior state for the resource, along with the given configuration state, to create a planned new state for the resource
3.Terraform CLI sends a Terraform Plugin Protocol request to create the new resource with its planned new state data
4.If the Terraform Plugin is using a higher-level library, such as the Terraform Plugin Framework, that library receives the request and translates the Terraform Plugin Protocol data types into the expected library types
5.Terraform Plugin invokes the resource creation function with the planned new state data
- The planned new state data is converted into a remote system request (e.g., API creation request) that is invoked
- The remote system response is received and the data is converted into an applied new state
6.If the Terraform Plugin is using a higher-level library, such as the Terraform Plugin Framework, that library translates the library types back into Terraform Plugin Protocol data types
7.Terraform Plugin responds to Terraform Plugin Protocol request with the new state data
8.Terraform CLI verifies and stores the new state





[refer1](https://hashicorp.github.io/terraform-provider-aws/data-handling-and-conversion/)
[refer2](https://manningbooks.medium.com/the-lifecycle-of-a-terraform-resource-8f5cc0cd48c8)
