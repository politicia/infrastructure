variable "environment" {
    type = string
    description = "Current environment between Dev/Prod"
}

variable "politicia_media_bucket_id" {
    type = string
    description = "Bucket ID of the media bucket"
}

variable "politicia_media_bucket_domain_name" {
    type = string
    description = "Bucket domain name of the media bucket"
}

variable "politicia_thumbnail_bucket_id" {
    type = string
    description = "Bucket ID of the thumbnail bucket"
}

variable "politicia_thumbnail_bucket_domain_name" {
    type = string
    description = "Bucket domain name of the thumbnail bucket"
}

variable "public_allowed_http_methods" {
    type = list(string)
    description = "HTTP Methods allowed to use on Cloudfront"
}

variable "public_cached_http_methods" {
    type = list(string)
    description = "HTTP Methods to cache on Cloudfront"
}

variable "cloudfront_restriction_type" {
    type = string
    description = "Type of Restriction to act"
}

variable "cloudfront_restriction_countries" {
    type = list(string)
    description = "Blacklist/Whitelist of Countries allowed to access"
}
