terraform {
  required_version = "~> 0.12"

  backend "s3" {
    bucket         = "aws_lab"
    key            = "aws_lab.tfstate"
    region         = "us-west-2"
    dynamodb_table = "aws_lab"
  }
}

