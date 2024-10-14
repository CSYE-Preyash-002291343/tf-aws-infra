variable "region" {
  description = "The AWS region to create resources in."
  type        = string
}

variable "profile" {
  description = "The AWS profile to use."
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
