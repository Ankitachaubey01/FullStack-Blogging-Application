variable "environment" {}
variable "region" {}

variable "vpc_cidr" {}
variable "vpc_name" {}

variable "subnet_count" {
  type = number
}

variable "availability_zones" {
  type = list(string)
}

variable "map_public_ip" {
  type = bool
}

variable "eks_cluster_name" {}
variable "eks_version" {}

variable "node_group_name" {}
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

variable "ssh_key_name" {}

variable "tf_state_bucket" {}

