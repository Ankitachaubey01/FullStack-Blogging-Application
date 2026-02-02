terraform {
	backend s3 {
    bucket = "tf_state_bucket"
    region = "us-west-2"
  }
}

