resource "aws_s3_bucket" "cloud-resume-static-website-bucket" {
  bucket = "cloud-resume-static-website-bucket"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_cloudfront_distribution" "website_distribution" {
  aliases = [
    "joe-resume.com",
    "www.joe-resume.com",
  ]
  is_ipv6_enabled = true
  enabled         = true
  default_cache_behavior {
    allowed_methods = [
      "GET",
      "HEAD",
    ]
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    cached_methods = [
      "GET",
      "HEAD",
    ]
    compress               = true
    default_ttl            = 0
    max_ttl                = 0
    min_ttl                = 0
    smooth_streaming       = false
    target_origin_id       = "cloud-resume-static-website-bucket.s3-website.eu-west-3.amazonaws.com"
    trusted_key_groups     = []
    trusted_signers        = []
    viewer_protocol_policy = "allow-all"
  }
  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }

  }

  viewer_certificate {
    acm_certificate_arn            = "arn:aws:acm:us-east-1:557921428261:certificate/0d0d8b06-7fcb-4883-9cb5-3bb6cd0f27ad"
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }

  origin {
    connection_attempts = 3
    connection_timeout  = 10
    domain_name         = "cloud-resume-static-website-bucket.s3-website.eu-west-3.amazonaws.com"
    origin_id           = "cloud-resume-static-website-bucket.s3-website.eu-west-3.amazonaws.com"

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols = [
        "TLSv1.2",
      ]
    }

  }

}


