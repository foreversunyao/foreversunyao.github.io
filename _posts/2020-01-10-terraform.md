---
layout: post
title: "Terraform"
date: 2020-01-10 12:25:06
description: Terraform hashicorp Infrastructure as code
tags:
 - cloud
---

**What is Terraform**
Terraform is an open source command line tool that can be used to provision any kind of infrastructure on dozens of different platforms and services. Terraform code is written in HCL or the HashiCorp Config Language.
With Terraform you simply declare resources and how you want them configured and then Terraform will map out the dependencies and build everything for you.
Terraform is declaretive language, which describes the intended goals instead of the steps to reach that goal.

**Concepts**

- Configurations
A Terraform configuration is the text file that contains the infrastructure resource definitions. You can write Terraform configurations in either Terraform format (using the .tf extension) or in JSON format (using the .tf.json extension)

- Providers
A provider can be anything in the realm of Infrastructure as a Service (IaaS), Platform as a Service (PaaS), or Software as a Service (SaaS). This includes Microsoft Azure, Google Cloud, Amazon Web Services, GitHub, and much, much more. Through provider you get access to resources.

- Resources
Terraform resources (in this instance, aws_s3_bucket) are the components of your infrastructure, and they always belong to a specific provider.

- Variables
Variables serve as parameters for a Terraform module, allowing aspects of the module to be customized without altering the module's own source code, and allowing modules to be shared between different configurations.

- state
current state
- core
analyse config and current state to generate plan: what needs to be created/updated/destroyed
execute the plan with providers

**Command**
```
Common commands:
    apply              Builds or changes infrastructure
    console            Interactive console for Terraform interpolations
    destroy            Destroy Terraform-managed infrastructure
    env                Workspace management
    fmt                Rewrites config files to canonical format
    get                Download and install modules for the configuration
    graph              Create a visual graph of Terraform resources
    import             Import existing infrastructure into Terraform
    init               Initialize a Terraform working directory
    output             Read an output from a state file
    plan               Generate and show an execution plan
    providers          Prints a tree of the providers used in the configuration
    refresh            Update local state file against real resources
    show               Inspect Terraform state or plan
    taint              Manually mark a resource for recreation
    untaint            Manually unmark a resource as tainted
    validate           Validates the Terraform files
    version            Prints the Terraform version
    workspace          Workspace management

All other commands:
    0.12upgrade        Rewrites pre-0.12 module source code for v0.12
    debug              Debug output management (experimental)
    force-unlock       Manually unlock the terraform state
    push               Obsolete command for Terraform Enterprise legacy (v1)
    state              Advanced state management
```
**import**
terraform can import current arn config to terraform state, example as bellow
```
#list arn
aws kafka list-configurations
terraform import  aws_msk_configuration.cfg_msg_limit_10mb [arn]
```
**Terraform vs Ansible**
- Ansible 
is a configuration management tool and to install and mamange software on **exisiting server instances**. (e.g., installation of packages, starting of services, installing scripts or config files on the instance). They do the heavy lifting of making one or many instances perform their roles without the user needing to specify the exact commands.
CM is a mutable infrastructure tool by default.
Procedural

- Terraform
immutable, like deploy a new server
Declarative, end/desired state,  always represent the latest state of your infrasture, without history/timming
Benefits when updating the infrastructure, dont care about how change, just what need to be done

Imperative = define exact steps - HOW
**modules**
```
main.tf -- 
outputs.tf -- outputs of module returns
variables.tf -- inputs
README.md -- documentation
modules -- sub modules
examples -- how to use the submodules
test -- automated integration tests
```

