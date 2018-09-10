#!/bin/bash -e

s3_bucket="josiahpeters.com"
region="us-west-2"
CLOUDFRONT_DISTRIBUTION_ID="E2UVAANEYZX3IC"

echo "Generating static website with Hugo"
hugo
echo "Deploying website to s3 bucket with public-read acl on static files"
aws s3 sync ./public/. s3://$s3_bucket/public/ --region $region --acl public-read --profile josiahpeters
echo "Deployment complete"