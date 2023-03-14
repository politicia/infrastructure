variable "environment" {
  type    = string
  description = "Current environment between Dev/Prod"
}

variable "politicia_media_cors_allowed_origins" {
  type    = list(string)
  description = "S3 CORS configuration for Media Bucket"
}

variable "politicia_thumbnail_cors_allowed_origins" {
  type    = list(string)
  description = "S3 CORS configuration for Thumbnail Bucket"
}