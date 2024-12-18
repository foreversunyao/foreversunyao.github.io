---
layout: post
title: "Terraform"
date: 2021-01-10 12:25:06
description: Terraform hashicorp Infrastructure as code, terragrunt
tags:
 - terraform
---


# think terraform in another way
[refer](https://spacelift.io/blog/how-to-use-terraform-variables)
```
terraform/module == function
input variables == arguments
output variables == return values
local variables == local variables
```

**input variables**
The difference between local and input variables is that input variables allow you to pass values before the code execution.
Further, the main function of the input variables is to act as inputs to modules. Modules are self-contained pieces of code that perform certain predefined deployment tasks. Input variables declared within modules are used to accept values from the root directory.

**Output variables**
This information is also available in Terraform state files. But state files are large, and normally we would have to perform an intricate search for this kind of information.
Output variables in Terraform are used to display the required information in the console output after a successful application of configuration for the root module. 
Output variables are used by child modules to expose certain values to the root module. 



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
**IAM and SA**
- grant IAM role To SA account for pods requesting AWS resource, such as logging to kinesis
- oidc_fully_qualified_subjects

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

- state file
1. terraform.tfstate
When you run terraform apply command to create an infrastructure on cloud, Terraform creates a state file called “terraform.tfstate”. This State File contains full details of resources in our terraform code. When you modify something on your code and apply it on cloud, terraform will look into the state file, and compare the changes made in the code from that state file and the changes to the infrastructure based on the state file.  
2. s3 bukcet and dynamodb
share access for statefile and lock/unlock when writing
3. terraform workspaces
We can give a single file of the resources for multiple environments. So, if you need to modify only in staging environment, you can do it with workspaces.
on S3 buckets, we have a folder env:/ , and workspaces folders under it.
create ec2 in different env, like default/test1/prod1

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

terraform state list
terraform state show <resource_name>
terraform state mv <resource_name>
terraform state pull/push
terraform destroy --target resource_name


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

**state**
a state is a metadata repository of your infra configration. terraform.tfstate stores the bindings between objects in a remote system and resource instances.
![img]({{ '/assets/images/cloud/cloud_terraform_state' | relative_url }}){: .center-image }*(°0°)*
  

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
