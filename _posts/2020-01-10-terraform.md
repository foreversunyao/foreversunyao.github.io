---
layout: post
title: "Terraform"
date: 2021-01-10 12:25:06
description: Terraform hashicorp Infrastructure as code, terragrunt
tags:
 - cloud
---

**example**
```
#variables.tf
variable "sg_name" { } 
variable "sg_desc" { }

#overrides.hcl
inputs = {
  sg_name = aaa
  sg_desc = bbb
}

#xx.tf
resource "example_resource" "example_name" {
  count       = var.enable_xxx ? 1 : 0
  name        = var.sg_name
  description = var.sg_desc
  policy = data.example_data.policy_rules.json
}

module "my_module" {
  count = var.enable_xxx ? 1 : 0
  source = "./modules/example_mod.tf"
  name = "xxx-${var.account_env}-${module.aws_ssm_parameter_ais.account_id}-${var.region_code}"
  account_id =
  kms_key_id =
  tags =
  vpc_endpoints =
  cidr_allow_list = ["0.0.0.0/0"]
}

data "example_data" "policy_rules" {
  statement {
    actions = []
    resources = []
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::xxx:role/account"
      ]
    }
  }
}

```


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

**meta-argument**
- count
create multiple instances according to the value assigned to the count
- for_each
create multiple resource instances as per a set of strings
- depends_on
specify explicit dependency
- lifecycle
define life cycle of a resource
- provider
select a non-default provider configuration

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
Modules are the main way to package and reuse resource configurations with Terraform.

```
main.tf -- resources need to create
outputs.tf -- outputs of module returns or pass resource attributes as input var to other module/resource
variables.tf -- variables
README.md -- documentation
modules -- sub modules, a bunch of files
examples -- how to use the submodules
test -- automated integration tests
```
![img]({{ '/assets/images/cloud/cloud_terraform.png' | relative_url }}){: .center-image }*(°0°)*

![img]({{ '/assets/images/cloud/cloud_terraform_output.png' | relative_url }}){: .center-image }*(°0°)*

**terragrunt**
[refer](https://www.padok.fr/en/blog/terraform-code-terragrunt#The_issue)
1. Terragrunt is a thin wrapper that provides extra tools for keeping your configurations DRY, working with multiple Terraform modules, and managing remote state.
2. features
- Explicit dependencies: Share your state easily
'variables' must be populated before run and static file in terraform, but in terragrunt 'input' can be used to dynamically supply these variables
- Terragrunt dependencies only define their state configuration once.
In Terraform, I have to define the dependencies and then, in every single module that requires them(repeatedly)
- Terragrunt applies dependencies in their implied order.
Terragrunt creates a dependency tree, and runs all commands in the proper order such that all necessary dependencies are available at execution time.

- decouple
The main advantage of Terragrunt is that it allows decoupling the logic of your code Terraform (which lies in your Terraform modules) from its implementation (which lies in the configuration of the different environments calling Terraform modules). Terragrunt can thus be considered a tool to orchestrate your Terraform modules.

- terragrunt.hcl
terragrunt.hcl file specifies a terraform { ...  } block that specifies from where to download the Terraform code, as well as the environment-specific values for the input variables in that Terraform code.
```
terraform {
  # Deploy version v0.0.3 in stage
  source = "git::git@github.com:foo/modules.git//app?ref=v0.0.3"
}

inputs = {
  instance_count = 3
  instance_type  = "t2.micro"
}
```


**Helm Provider**
The Helm provider is used to deploy software packages in Kubernetes.
resource: helm_release
A Release is an instance of a chart running in a Kubernetes cluster.
A Chart is a Helm package. It contains all of the resource definitions necessary to run an application, tool, or service inside of a Kubernetes cluster.

**tools**
[atlantis](https://github.com/runatlantis/atlantis)
