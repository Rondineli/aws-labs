#!/bin/bash

set -e

AWS_REGION=${AWS_DEFAULT_REGION:-"us-west-2"}
ROOT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
DATABASE_SCHEMA="${DATABASE_DEFINITIONS:-scripts/database.json}"

echo "Executing creation of the table on region: ${AWS_REGION}"

if [ -z "${ENDPOINT_URL}" ]; then
	echo "Executing with endpoint for: ${ENDPOINT_URL}"
	aws dynamodb create-table --cli-input-json file://${ROOT_PATH}/$DATABASE_SCHEMA --endpoint-url ${ENDPOINT_URL}
else
	aws dynamodb create-table --cli-input-json file://${ROOT_PATH}/$DATABASE_SCHEMA
fi
echo $ROOT_PATH


echo "Executing creation of the S3 bucket on region ${AWS_REGION}"
aws s3api create-bucket --bucket aws_lab --region ${AWS_REGION}

# Creating first table and s3 bucket that first terraform setup will use
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

