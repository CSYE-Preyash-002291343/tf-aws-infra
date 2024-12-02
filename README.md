# Terraform Infrastructure Deployment

This repository contains the Terraform configurations for deploying a web application infrastructure on AWS. The setup includes various AWS services such as EC2, RDS, S3, Auto Scaling Groups, Load Balancers, and more.

## File Structure

- **ALB.tf**: Configures the Application Load Balancer that routes traffic to the appropriate EC2 instances.
- **ASG.tf**: Defines the Auto Scaling Group that manages the EC2 instances for handling the application load.
- **cloudwatchAlarm.tf**: Sets up CloudWatch Alarms for monitoring the infrastructure.
- **devSSL.tf**: Manages the SSL certificate for the development environment using AWS ACM.
- **ec2-LT.tf**: Contains the Launch Template for the EC2 instances specifying the instance type, AMI, and associated security configurations.
- **IAM.tf**: Includes definitions for IAM roles and policies required by various services.
- **KMS.tf**: Handles the creation of KMS keys for encrypting resources such as RDS databases and S3 buckets.
- **lambda.tf**: Configures AWS Lambda functions used by the application.
- **locals.tf**: Defines local variables used across multiple Terraform files.
- **providers.tf**: Specifies the Terraform provider configuration, in this case, AWS.
- **rdsInstance.tf**: Configures the RDS instance for the relational database.
- **rdsParamGroup.tf**: Manages parameter groups for the RDS instances.
- **rdsSubnetGroup.tf**: Defines subnet groups for the RDS instances to ensure they reside within the VPC.
- **README.md**: This file.
- **route_tables.tf**: Configures route tables within the VPC.
- **route_tables_associations.tf**: Associates subnets with specific route tables.
- **route53_A.tf**: Manages Route 53 DNS records for the application.
- **s3.tf**: Sets up S3 buckets for storing application data.
- **secretsManager.tf**: Manages secrets via AWS Secrets Manager, primarily for storing sensitive configuration like database credentials.
- **securityGroup.tf**: Defines security groups that specify allowable traffic to and from EC2 instances and other resources.
- **sns.tf**: Configures SNS topics for sending notifications.
- **subnets.tf**: Manages the subnets within the VPC.
- **terraform.tfstate**: Stores the state of your Terraform managed infrastructure.
- **variables.tf**: Declares variables to be used across the configurations.
- **vpc.tf**: Sets up the Virtual Private Cloud (VPC) where all resources will reside.

## Setup Instructions

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

## Security
Ensure that your AWS credentials are not hardcoded in any of the Terraform files. Use environment variables or AWS IAM roles where applicable.

## Statement to import the certifcate into DEMO AWS Account
aws acm import-certificate --certificate fileb://demo_preyash_me.crt --private-key fileb://private.key --certificate-chain fileb://demo_preyash_me.ca-bundle --region us-east-1 --profile demo

## Contributors
- [Preyash Mehta](https://www.linkedin.com/in/preyash-mehta/) - Project Lead

## License
This project is licensed under the [MIT License](link-to-license-file).