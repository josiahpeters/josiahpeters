
locals {
  s3_origin_id = "S3-${var.primary_domain}"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin = [
    {
      domain_name = "${aws_s3_bucket.primary_domain.bucket_regional_domain_name}"
      origin_id   = "${local.s3_origin_id}"
      origin_path = "/public"
    }
  ]

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  tags {
    site        = "${var.primary_domain}"
    Environment = "${var.environment_tag}"
  }

  /*
  logging_config {
    include_cookies = false
    bucket          = "mylogs.s3.amazonaws.com"
    prefix          = "myprefix"
  }
  */

  aliases = "${var.cloudfront_aliases}"
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${local.s3_origin_id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  price_class = "PriceClass_200"
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    # cloudfront_default_certificate = true
    acm_certificate_arn = "${aws_acm_certificate.cert.arn}"
    ssl_support_method  = "sni-only"
  }
  depends_on = ["aws_acm_certificate_validation.cert"]
}
