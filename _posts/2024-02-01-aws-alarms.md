---
layout: post
title: "AWS alarms"
date: 2024-02-01 10:25:06
description: cloudwatch, monitoring,  alarms, terraform, RDS
tags:
 - cloud
---
[RDS metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Best_Practice_Recommended_Alarms_AWS_Services.html#RDS)

# Monitoring metrics
1. Monitoring plan
```
What are your monitoring goals?

Which resources will you monitor?

How often will you monitor these resources?

Which monitoring tools will you use?

Who will perform the monitoring tasks?

Whom should be notified when something goes wrong?
```

2. Performance baseline(take RDS as an example)
To achieve your monitoring goals, you need to establish a baseline. To do this, measure performance under different load conditions at various times in your Amazon RDS environment.
```
Network throughput

Client connections

I/O for read, write, or metadata operations

Burst credit balances for your DB instances
```

3. Performance guidelines
```
High CPU or RAM consumption 

Disk space consumption

Network traffic 

Database connections 

IOPS metrics 
```

# Alarm
[refer](https://medium.com/@The_Anshuman/aws-cloudwatch-alarm-in-terraform-bb6e69ac922d)

```
provider "aws" {
  region = "your_aws_region"
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "CPUUtilizationAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300  # 5 minutes
  statistic           = "Average"
  threshold           = 80   # Set your threshold value

  dimensions = {
    InstanceId = "your_instance_id"
  }

  alarm_description = "Alarm when CPU utilization is greater than or equal to 80%"

  actions_enabled = true

  alarm_actions = ["arn:aws:sns:your_aws_region:your_account_id:your_sns_topic_arn"]

  ok_actions = ["arn:aws:sns:your_aws_region:your_account_id:your_sns_topic_arn"]
}
```

# Demo
[refer](https://github.com/cloudposse/terraform-aws-rds-cloudwatch-sns-alarms)

