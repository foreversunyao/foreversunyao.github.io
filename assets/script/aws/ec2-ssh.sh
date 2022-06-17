#!/bin/bash
REGION=$1
NODE=$2
ENV=$3

INSTANCE=`aws ec2 describe-instances --profile $ENV --region $REGION |  jq -r '.Reservations[] | .Instances[] | .PrivateDnsName + " " + .InstanceId'| grep $NODE | awk '{print $2}'`
AWS_PROFILE=$ENV AWS_SDK_LOAD_CONFIG=1 aws ssm start-session --target $INSTANCE  --region $REGION
