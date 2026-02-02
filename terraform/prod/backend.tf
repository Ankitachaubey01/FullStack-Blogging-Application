terraform {
	backend s3 {
    bucket = var.tf_state_bucket
	key    = "eks/prod/terraform.tfstate"
    region = "us-west-2"
  }
}

