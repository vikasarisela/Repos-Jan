#!/bin/bash

AMI_ID=ami-0220d79f3f480ecf5
SECURITY_GROUP=sg-05070ca66b56218cd

for instance in $@
do 
Instance_Id=$(aws ec2 run-instances \
--image-id ami-0220d79f3f480ecf5 \
--count 1 \
--instance-type t2.micro \
--security-group-ids sg-05070ca66b56218cd \
--tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
--query 'Instances[0].InstanceId' \
--output text)

if [ $instance != "frontend" ]; then
IP=$(aws ec2 describe-instances \
    --instance-ids $Instance_Id \
    --query 'Reservations[0].Instances[0].PrivateIpAddress' \
    --output text)
else 
IP=$(aws ec2 describe-instances \
    --instance-ids $Instance_Id \
    --query 'Reservations[0].Instances[0].PublicIpAddress' \
    --output text)
fi

echo "$IP, $instance" 

done 