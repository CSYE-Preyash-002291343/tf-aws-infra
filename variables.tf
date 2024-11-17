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

variable "key_name" {
  description = "The name of the key pair to use for the EC2 instance."
  type        = string
  default     = "SSH-Key Pair"
}

variable "launch_template" {
  description = "The name of the launch template."
  type        = string
  default     = "csye6225_asg"
}

variable "ASG" {
  description = "The name of the Auto Scaling Group."
  type        = string
  default     = "webapp_asg"
}

variable "LB-Port" {
  description = "The port for the load balancer."
  type        = number
  default     = 5000
}

variable "loadBalancerName" {
  description = "The name of the load balancer."
  type        = string
  default     = "webapp-alb"
}

variable "SENDGRID_API_KEY" {
  description = "The SendGrid API key."
  type        = string
}

variable "SENDGRID_FROM_EMAIL" {
  description = "The email address to send emails from."
  type        = string
}

variable "APP_BASE_URL" {
  description = "The base URL for the application."
  type        = string
}