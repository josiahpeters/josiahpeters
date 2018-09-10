resource "aws_route53_zone" "primary" {
  name = "${var.primary_domain}"

  tags {
    site        = "${var.primary_domain}"
    Environment = "${var.environment_tag}"
  }
}

resource "aws_route53_record" "domain-root" {
  zone_id    = "${aws_route53_zone.primary.zone_id}"
  name       = "${var.primary_domain}"
  type       = "A"
  depends_on = ["aws_route53_zone.primary"]

  alias {
    name                   = "${aws_cloudfront_distribution.s3_distribution.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.s3_distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "domain-www" {
  zone_id    = "${aws_route53_zone.primary.zone_id}"
  name       = "www.${var.primary_domain}"
  type       = "A"
  depends_on = ["aws_route53_zone.primary"]

  alias {
    name                   = "${aws_cloudfront_distribution.s3_distribution.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.s3_distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}
