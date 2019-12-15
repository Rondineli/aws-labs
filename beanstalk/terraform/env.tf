terraform {
  required_version = "~> 0.12"

  backend "s3" {
    bucket         = "aws-lab-first-load"
    key            = "aws_lab_beanstalk.tfstate"
    region         = "us-west-2"
    dynamodb_table = "aws_lab"
  }
}

