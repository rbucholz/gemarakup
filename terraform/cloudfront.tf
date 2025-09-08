# it may take several hours for a certificate to be issued so do a target apply first and wait
# https://aws.amazon.com/certificate-manager/faqs/#topic-3
resource "aws_acm_certificate" "gemarakup_cert" {
  provider          = aws
  domain_name       = "gemarakup.com"
  validation_method = "DNS"
  subject_alternative_names = ["*.gemarakup.com"]

  tags = {
    Name = "gemarakup"
  }
}

locals {
  s3_origin_id = "S3-gemarakup-frontend"
}

resource "aws_cloudfront_distribution" "gemarakup_s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.gemarakup_frontend.bucket_regional_domain_name
    # origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = local.s3_origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "gemarakup CloudFront Distribution"
  default_root_object = "index.html"

#   logging_config {
#     include_cookies = false
#     bucket          = "mylogs.s3.amazonaws.com"
#     prefix          = "myprefix"
#   }

  aliases = [ "gemarakup.com", "www.gemarakup.com" ]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
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

  tags = {
    Environment = "dev"
  }

  viewer_certificate {
    acm_certificate_arn = "arn:aws:acm:us-east-1:106590867164:certificate/7dcebe84-8ac1-4abd-9428-dff6ea0958e4"
    cloudfront_default_certificate = true
    ssl_support_method = "sni-only"
  }
}