---
layout: post
title: "Terraform cicd"
date: 2024-12-01 12:25:06
description: terraform, pipeline, ci, cd 
tags:
 - terraform
---


# develop and deploy stages
VScode Extension(terraform) -> terraform validate(local) -> commit(pre-commit hook) -> push -> pull request(infracost, terrform validate, terraform plan, tf init, security) -> merge -> deploy-> test -> staging -> prod

# repos
[infracost](https://github.com/infracost/infracost)
[trivy](https://github.com/aquasecurity/trivy)
[pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)
