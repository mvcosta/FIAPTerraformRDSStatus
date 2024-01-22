terraform {
  backend "s3" {
    bucket = "terraform-backend-mv"
    key    = "db-status"
    region = "us-east-1"
  }
}

