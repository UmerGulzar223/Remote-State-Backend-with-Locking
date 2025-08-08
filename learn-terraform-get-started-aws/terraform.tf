terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }
  backend "s3" {
    bucket         = "my-s3-bucket-umergulzar223"
    key            = "terraform.tfstate"
    region        = "ap-south-1"
    dynamodb_table = "state-table"
  }
  required_version = ">= 1.2"
}
