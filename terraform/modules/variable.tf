variable "environment" {
  description = "Environment name (dev, qa, prod)"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

#VPC related variables

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "vpc_name" {
  type        = string
}

#Subnet related variables
variable "subnet_count" {
  type    = number
  default = 2
}

variable "availability_zones" {
  type = list(string)
}

variable "map_public_ip" {
  type    = bool
  default = true
}

#EKS Cluster related variables

variable "eks_cluster_name" {
  type = string
}

variable "eks_version" {
  type    = string
  default = "1.31"
}

variable "node_group_name" {
  type = string
}

variable "instance_types" {
  type = list(string)
}

variable "desired_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "ssh_key_name" {
  type = string
}


#SSH Key Pair variable


#S3 Bucket for Terraform State

#variable "tf_state_bucket" {
#  type = string
#}

