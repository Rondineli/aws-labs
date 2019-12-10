#!/bin/bash

set -e

AWS_REGION=${AWS_DEFAULT_REGION:-"us-west-2"}
ROOT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
DATABASE_SCHEMA="${DATABASE_DEFINITIONS:-definitions/database.json}"

echo "Install latest terraform 0.12"
rm -rf $HOME/.tfenv || echo "ok"
git clone git@github.com:tfutils/tfenv.git $HOME/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile
ln -s ~/.tfenv/bin/* /usr/local/bin
tfenv install latest

echo "Executing creation of the table on region: ${AWS_REGION}"

if [ ! -z "${ENDPOINT_URL}" ]; then
	echo "Executing with endpoint for: ${ENDPOINT_URL}"
	aws dynamodb create-table --cli-input-json file://${ROOT_PATH}/$DATABASE_SCHEMA --endpoint-url ${ENDPOINT_URL}
else
	aws dynamodb create-table --cli-input-json file://${ROOT_PATH}/$DATABASE_SCHEMA
fi
echo $ROOT_PATH

echo "Executing creation of the S3 bucket on region ${AWS_REGION}"
aws s3api create-bucket --bucket aws-lab-first-load --region ${AWS_REGION} --create-bucket-configuration LocationConstraint=${AWS_REGION}
