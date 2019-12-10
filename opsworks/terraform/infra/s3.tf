resource "aws_s3_bucket" "opsworks_cookbooks" {
  bucket = "aws-labs-opsworks-cookbooks"
  acl    = "private"

  tags = {
    Name = "aws-labs-opsworks-cookbooks"
    Environment = "Lab"
  }

}
