resource "aws_s3_bucket" "primary_domain" {
  bucket = "${var.primary_domain}"
  acl    = "private"

  tags {
    site        = "${var.primary_domain}"
    Environment = "${var.environment_tag}"
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

locals {
  s3_origin_id = "S3-${var.primary_domain}"
}
