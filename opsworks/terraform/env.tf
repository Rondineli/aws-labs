terraform {
  required_version = "~> 0.112"

  backend "s3" {
    bucket         = "aws-lab-opsworks"
    key            = "aws_lab_opsworks.tfstate"
    region         = "us-west-2"
    dynamodb_table = "aws_lab_opsworks"
  }
}

