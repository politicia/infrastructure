variable "AWS_ACCESS_KEY" {
  type = string
  description = "AWS Access Key"
}

variable "AWS_SECRET_KEY" {
  type = string
  description = "AWS Secret Key"
}

variable "region" {
  type = string
  description = "AWS Region in use"
}

variable "politicia_media_cors_allowed_origins" {
  type    = list(string)
  description = "S3 CORS configuration for Media Bucket"
}

variable "politicia_thumbnail_cors_allowed_origins" {
  type    = list(string)
  description = "S3 CORS configuration for Thumbnail Bucket"
}

variable "vpc_cidr" {
    type = string
    description = "Subnet Mask of VPC"
}

variable "public_subnets_cidr" {
    type = list(string)
    description = "Subnet Mask of Public Subnets as a List"
}

variable "private_subnets_cidr" {
    type = list(string)
    description = "Subnet Mask of Private Subnets as a List"
}