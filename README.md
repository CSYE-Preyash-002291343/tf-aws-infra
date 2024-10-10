# AWS VPC Terraform Configuration

## Overview
This repository contains Terraform configurations for deploying a VPC along with associated networking resources on AWS. The setup includes public and private subnets across multiple availability zones, an Internet Gateway, and separate route tables for public and private subnets.

## Architecture
The VPC is configured with:
- A **VPC** in the AWS region specified in the terraform variables.
- **Internet Gateway** attached to the VPC for outbound internet access.
- **Public Subnets** across multiple availability zones with routes configured to the internet gateway.
- **Private Subnets** across multiple availability zones without direct access to the internet.
- **Route Tables** ensuring proper routing for both public and private subnets.


## Prerequisites
- AWS account and AWS CLI configured with appropriate credentials.
- Terraform installed on your local machine.

## Usage
1. **Initialize Terraform**:
   Run `terraform init` to initialize the working directory and download required providers.

2. **Plan the Deployment**:
   Execute `terraform plan` to preview the changes that Terraform plans to make based on your configuration files.

3. **Apply the Configuration**:
   Apply the configuration with `terraform apply`. Confirm the action by typing `yes` when prompted to proceed.

4. **Destroy the Infrastructure**:
   When you no longer need the deployed resources, you can run `terraform destroy` to remove all resources created by this Terraform configuration.

## Customization
- You can modify the `terraform.tfvars` file to update the configuration settings such as the AWS region, CIDR blocks, and availability zones according to your requirements.

## Outputs
This Terraform configuration outputs the following:
- `vpc_id`: The ID of the created VPC.
- `public_subnet_ids`: A list of IDs for the created public subnets.
- `private_subnet_ids`: A list of IDs for the created private subnets.
- `internet_gateway_id`: The ID of the Internet Gateway.