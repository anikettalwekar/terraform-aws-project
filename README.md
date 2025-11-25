terraform-aws-project
Project Overview

This project builds a complete AWS infrastructure using Terraform, integrated with Jenkins for automated CI/CD deployment.
All resources follow modular Terraform design and are deployed in the ap-south-1 (Mumbai) region.

AWS Services Used

VPC

Subnets (Public and Private)

Internet Gateway

NAT Gateway

Route Tables and Associations

EC2 Instances

Security Groups

RDS MySQL

IAM Roles and Instance Profiles

Elastic IP

Jenkins (for automation)

Project Architecture

The infrastructure includes:

One custom VPC

Two public subnets

Two private subnets

One Internet Gateway

One NAT Gateway

Route tables for public and private routes

Two EC2 web instances placed in public subnets

One RDS MySQL instance placed in private subnets

IAM role with policies (SSM, S3 Read Only)

Jenkins pipeline for automated deployment

terraform-aws-project/
│
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── rds/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── iam/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
│
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
└── Jenkinsfile

Jenkins Pipeline Flow

Checkout code from GitHub

Terraform Init

Terraform Plan

Terraform Apply using auto-approve

Outputs displayed:

EC2 public IPs

Private subnet IDs

Public subnet IDs

RDS endpoint

VPC ID

How to Deploy
Step 1: Clone the repository

git clone https://github.com/anikettalwekar/terraform-aws-project.git

Step 2: Modify terraform.tfvars

Set your values:

VPC CIDR

Subnet CIDRs

Key pair name (existing in AWS)

DB username/password

Project name

Step 3: Initialize Terraform

-terraform init-

Step 4: Review the plan

-terraform plan -var-file=terraform.tfvars.example-

Step 5: Apply the changes

-terraform apply -var-file=terraform.tfvars.example -auto-approve-


Jenkins Requirements

Jenkins EC2 with Java installed

Terraform installed

AWS Credentials configured under Jenkins credentials

AWS plugin installed

Pipeline created with the provided Jenkinsfile

Outputs

After successful deployment Terraform displays:

EC2 public IPs

Subnet IDs

VPC ID

RDS endpoint

Clean Up Resources

To destroy all resources: terraform destroy -var-file=terraform.tfvars.example -auto-approve

Notes

Key pair used must already exist in AWS

RDS is deployed in private subnets

NAT Gateway is required for private subnets outbound access

EC2 instances are created in public subnets

All modules are reusable and parameterized

