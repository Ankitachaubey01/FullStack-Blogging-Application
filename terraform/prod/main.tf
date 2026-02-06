module "EKS_Cluster" {
  source = "../modules"
  
  region                = var.region
  environment           = var.environment
  vpc_name              = var.vpc_name
  vpc_cidr              = var.vpc_cidr
  availability_zones    = var.availability_zones
  eks_cluster_name      = var.eks_cluster_name
  node_group_name       = var.node_group_name
  instance_types        = var.instance_types
  desired_size          = var.desired_size
  min_size              = var.min_size
  max_size              = var.max_size
  tf_state_bucket       = var.tf_state_bucket
  
}
