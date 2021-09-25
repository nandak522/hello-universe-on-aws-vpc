terraform {
  backend "s3" {
    bucket = "terraform-hello-universe"
    key    = "tf-state-store"
    region = "us-east-1"
  }
}
