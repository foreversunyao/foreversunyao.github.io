---
layout: post
title: "Terraform plugin"
date: 2024-09-01 12:25:06
description: provider, terraform, plugin, framework, sdkv2 
tags:
 - terraform
---

# What is terraform
terraform is for customers to easier manage the APIs.

# When need a custom provider
The use case like where your company provides an API to your customers, but those customers heavily rely of Terraform to help them build and maintain their complex infrasturcture. 

# Plugin framework
Each plugin exposes an implementation for a specific service, such as AWS, or provisioner, such as bash. All Providers and Provisioners used in Terraform configurations are plugins. They are executed as a separate process and communicate with the main Terraform binary over an RPC interface.

[example](https://github.com/hashicorp/terraform-provider-scaffolding-framework)

- Key Concepts
Provider Servers encapsulate all Terraform plugin details and handle all calls for provider, resource, and data source operations by implementing the Terraform Plugin Protocol. They are implemented as binaries that the Terraform CLI downloads, starts, and stops.

Providers are the top level abstraction that define the available resources and data sources for practitioners to use and may accept its own configuration, such as authentication information.

Schemas define available fields for provider, resource, or provisioner configuration block, and give Terraform metadata about those fields.

Resources are an abstraction that allow Terraform to manage infrastructure objects, such as a compute instance, an access policy, or disk. Providers act as a translation layer between Terraform and an API, offering one or more resources for practitioners to define in a configuration.

Data Sources are an abstraction that allow Terraform to reference external data. Providers have data sources that tell Terraform how to request external data and how to convert the response into a format that practitioners can interpolate.

Functions are an abstraction that allow Terraform to reference computational logic. Providers can implement their own custom logic functions to augment the Terraform configuration language built-in functions.

