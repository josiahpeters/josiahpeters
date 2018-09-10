variable "primary_domain" {
  description = "AWS region"
}

variable "environment_tag" {
  description = "Tag that every resource created will get"
}

variable "cloudfront_aliases" {
  description = "List of domain aliases that cloud front will listen to"
   type = "list"
}


// Variables for authentication, do not check default values into source control!
variable "aws_region" {
  description = "AWS region"
}

variable "aws_access_key" {
  description = "AWS access key"
}

variable "aws_secret_key" {
  description = "AWS secret key"
}
