---
layout: post
title: aws gcloud cheat sheet
date: 2020-01-13 09:25:06
description: gcloud cheat sheet, aws cheat sheet 
tags: 
- cloud
---

**aws**
[cheat sheet](https://github.com/mdminhazulhaque/aws-cli-cheatsheet)
[refer](https://www.bluematador.com/learn/aws-cli-cheatsheet)
```
alias aws-prod="aws --profile work-prod"
alias aws-prod-login="aws-login -b x-chrome <profile>"
aws ec2 describe-instances | jq ...
aws ec2 describe-instances --instance-ids i-xxx | jq -r '.Reservations[] | .Instances[] | .PrivateDnsName + " " + .ImageId' | sort -k2
aws ec2 describe-images --image-ids ami-xx --region=us-west-2
aws ec2 describe-vpcs
aws ec2 describe-subnets --filter Name=vpc-id,Values=vpc-0d1c1cf4e980ac593
aws ec2 describe-security-groups
aws ec2 describe-instance-type-offerings --location-type availability-zone --filters Name=location,Values=eu-west-3b --region eu-west-3 | jq '.InstanceTypeOfferings[] | .InstanceType'
aws ssm start-session --target <instanceid> --profile PROFILE --region REGION
aws  --profile PROFILE --region REGION  autoscaling describe-auto-scaling-groups | jq '.AutoScalingGroups[] | .AutoScalingGroupName' 
aws autoscaling describe-scaling-activities --auto-scaling-group-name AAA
aws s3 ls
aws s3 cp s3://my-awesome-new-bucket .
aws s3api help
aws apigateway get-rest-apis 
aws elbv2 describe-load-balancers --query 'LoadBalancers[*].DNSName'
aws elbv2 describe-target-groups | jq -r '.TargetGroups[] | .TargetGroupArn'
aws rds describe-db-clusters 
aws lambda list-functions 
aws lambda get-function --function-name DynamoToSQS
aws cloudwatch describe-alarms
aws route53 list-hosted-zones
aws dynamodb list-tables
aws cloudfront list-distributions
aws ecr describe-repositories | jq -r '.repositories[] | .repositoryName'
aws eks list-clusters | jq -r .clusters[]
aws eks update-kubeconfig --name devtest
aws iam list-users | jq -r '.Users[]|.UserId+" "+.UserName'
aws ec2 create-volume --availability-zone=eu-west-1a --size=10 --volume-type=gp2
aws ec2 terminate-instances --instance-ids INSTANCE_ID

```
**terraform/terragrunt**
```
terraform state list
terragrunt apply -target=''
```

**gcp**
[cheat sheet](https://gist.github.com/pydevops/cffbd3c694d599c6ca18342d3625af97)
