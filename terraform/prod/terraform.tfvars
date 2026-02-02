
  # -------- Global --------
  environment = "prod"
  region      = "us-west-2"

  # -------- VPC --------
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "eks-VPC"

  # -------- Subnets --------
  subnet_count        = 2
  availability_zones = ["us-west-2a", "us-west-2b"]
  map_public_ip       = true

  # -------- EKS --------
  eks_cluster_name = "prod-eks-cluster"
  eks_version      = "1.28"

  # -------- Node Group --------
  node_group_name = "prod-node-group"
  instance_types  = ["t3.small"]
  desired_size    = 3
  min_size        = 2
  max_size        = 4
  ssh_key_name    = "prod-ssh-key"
  # -------- Backend --------
  tf_state_bucket = "mynew-state-bucket"
  tf_lock_table  = "my-Ankita-lock-table"

