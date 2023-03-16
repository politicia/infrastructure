resource "aws_cloudfront_origin_access_identity" "media_bucket_origin_access_identity" {
  comment = "Distribution of media bucket"
}

resource "aws_cloudfront_distribution" "media_bucket_distribution" {
  origin {
    domain_name = var.politicia_media_bucket_domain_name
    origin_id   = var.politicia_media_bucket_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.media_bucket_origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Cloudfront Distribution for ${var.environment} media s3 bucket"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = var.public_allowed_http_methods
    cached_methods   = var.public_cached_http_methods
    target_origin_id = var.politicia_media_bucket_id

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

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = var.cloudfront_restriction_type
      locations        = var.cloudfront_restriction_countries
    }
  }

  tags = {
    Environment = var.environment
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

resource "aws_cloudfront_origin_access_identity" "thumbnail_bucket_origin_access_identity" {
  comment = "Distribution of thumbnail bucket"
}

resource "aws_cloudfront_distribution" "thumbnail_bucket_distribution" {
  origin {
    domain_name = var.politicia_thumbnail_bucket_domain_name
    origin_id   = var.politicia_thumbnail_bucket_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.thumbnail_bucket_origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Cloudfront Distribution for ${var.environment} thumbnail s3 bucket"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = var.public_allowed_http_methods
    cached_methods   = var.public_cached_http_methods
    target_origin_id = var.politicia_thumbnail_bucket_id

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

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = var.cloudfront_restriction_type
      locations        = var.cloudfront_restriction_countries
    }
  }

  tags = {
    Environment = var.environment
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}