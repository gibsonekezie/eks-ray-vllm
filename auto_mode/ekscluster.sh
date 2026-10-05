#bin/bash

#=================================================================================================================
# NOTE: This path assumes you have an existing vpc set up even if it's the default vpc that comes with your account
# ================================================================================================================

#=================================
# Variables for EKS create command
# ================================

export CLUSTER_NAME="eksgpu"
export AWS_REGION="us-east-1"
export AZS=$(aws ec2 describe-availability-zones \
  --region ${AWS_REGION} \
  --query "AvailabilityZones[?ZoneId!='use1-az3' && ZoneId!='usw1-az2' && ZoneId!='cac1-az3'].ZoneName" \
  --output text | tr '\t' ',')
echo $AZS

#===================================================================
# Command to create eks cluster using automode
# 
# with eks auto mode a cluster ready for gpu workload is provisioned
# =================================================================
eksctl create cluster \
  --name=$CLUSTER_NAME \
  --region=$AWS_REGION \
  --enable-auto-mode \
  --version=1.36 \
  --zones=$AZS
