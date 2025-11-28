// Terraform scaffold (placeholder)
// Replace provider, backend, and resource blocks with real cloud config.
terraform {
  required_version = ">= 1.0"
}

provider "aws" {
  region = var.region
}

variable "region" {
  description = "AWS region"
  default = "us-east-1"
}

output "note" {
  value = "Replace this file with production-ready Terraform modules for VPC, EKS, RDS, etc."
}
