terraform {
  backend "s3" {
    bucket = "acams-training"
    region = "us-easta-2"
    key = "eks/terraform.tfstate"
  }
}