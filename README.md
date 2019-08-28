# [josiahpeters.com](https://josiahpeters.com)

## Content
Static website generated by Hugo.

## Infrastructure

AWS infrastructure provisioned with Terraform.
* CloudFront Distribution
* Route 53 Records
* ACM SSL Certificate
* S3 Bucket for hosting

## Deployment
Static website content deployed from aws cli to S3.

Todo:
* CloudFront cache invalidation on deploy