variable "region" {
  description = "The AWS region to create resources in."
  type        = string
}

variable "profile" {
  description = "The AWS profile to use."
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to launch."
  type        = string
}

variable "environment" {
  description = "The environment to deploy to."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones to use."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "ami-ID" {
  description = "The AMI to use for the EC2 instance."
  type        = string
}

variable "DB_USER" {
  description = "The username for the database."
  type        = string
}

variable "DB_PASS" {
  description = "The password for the database."
  type        = string
}

variable "DB_Engine" {
  description = "The database engine to use."
  type        = string
}

variable "RDS_INSTANCE" {
  description = "The RDS instance class to use."
  type        = string
}

variable "identifier" {
  description = "The identifier for the RDS instance."
  type        = string
}

variable "DB_NAME" {
  description = "The name of the database."
  type        = string
}

variable "ZoneID" {
  description = "The Hosted Zone ID for Route53."
  type        = string
}

variable "domain" {
  description = "The domain to use for Route53."
  type        = string
}

variable "ARN-dev" {
  description = "The ARN for the dev user."
  type        = string
}