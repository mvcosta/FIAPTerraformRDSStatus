terraform {
  backend "s3" {
    bucket = "terraform-backend-mv"
    key    = "db"
    region = "us-east-1"
  }
}

