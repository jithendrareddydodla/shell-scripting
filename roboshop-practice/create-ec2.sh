#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo You need to provide Instance name as argument
  exit 1
fi

NAME=$1

  aws ec2 describe-spot-instance-requests --filters Name=tag:Name,Values=${NAME} Name=state,Values=active --output table | grep InstanceId &>/dev/null
if [ $? -eq 0 ]; then
  echo -e "\e[3 1m Instance Already Exits\e[0m"
  exit 0
fi

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=Centos-7-DevOps-Practice" --output table | grep ImageId | awk '{print $4}')

aws ec2 run-instances --image-id ${AMI_ID} --instance-type t2.micro --instance-market-options "MarketType=spot,SpotOptions={SpotInstanceType=persistent,InstanceInterruptionBehavior=stop}" --tag-specifications "ResourceType=spot-instances-request,Tags=[{Key=Name,Value=${NAME}}]" "ResourceType=instance,Tags=[{Key=Name,Value=${NAME}}]" &>/dev/null
echo Instance Created

sleep 30

INSTANCE_ID=$(aws ec2 describe-spot-instance-requests --filters Name=tag:Name,Values=cart Name=state,Values=active --output table | grep InstanceId | awk '{print $4}')

IPADDRESS=$(aws ec2 describe-instances --instance-ids ${INSTANCE_ID} --output table | grep PrivateIpAddress | head -n 1 | awk '{print $4}')

sed -e "s/component/${NAME}/" -e "s/IPADDRESS/${IPADDRESS}/" record.json >/tmp/record.json
aws route53 change-resourse-record-sets --hosted-zone-id Z0923823L625NN01788B --change-batch file:///tmp/record.json &>/dev/null

echo DNS Record Created






