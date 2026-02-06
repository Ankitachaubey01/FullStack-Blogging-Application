output "cluster_id" {
  value = module.EKS_Cluster.cluster_id
}

output "node_group_id" {
  value = module.EKS_Cluster.node_group_id
}

output "vpc_id" {
  value = module.EKS_Cluster.vpc_id
}

output "subnet_ids" {
  value = module.EKS_Cluster.subnet_ids
}
