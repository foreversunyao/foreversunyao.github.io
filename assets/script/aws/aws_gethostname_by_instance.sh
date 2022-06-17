#!/bin/bash

ec2 describe-instances --region eu-west-3 --instance-ids $1
