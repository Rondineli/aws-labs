#resource "aws_dynamodb_table" "aws_lab_initial" {
#  name             = "aws_lab"
#  billing_mode     = "PAY_PER_REQUEST"
#  hash_key         = "LockID"
#  stream_enabled   = false
#  # stream_view_type = "NEW_AND_OLD_IMAGES"
#
#  attribute {
#    name = "LockID"
#    type = "S"
#  }
#
#  tags   = {
#    "Name" = "aws_lab"
#  }
#}

resource "aws_dynamodb_table" "aws_lab_opsworks" {
  name             = "aws_lab_opsworks"
  billing_mode     = "PAY_PER_REQUEST"
  hash_key         = "LockID"
  stream_enabled   = false
  # stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags   = {
    "Name" = "aws_lab_opsworks"
  }
}


