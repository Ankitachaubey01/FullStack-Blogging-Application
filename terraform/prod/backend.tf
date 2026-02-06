terraform {
	backend s3 {
    bucket = "my-ankita-state-bucket"
	key    = "eks/prod/terraform.tfstate"
    region = "us-west-2"
  }
}

