locals {
  production_availability_zones  = ["${var.region}a", "${var.region}c", "${var.region}d"]
  development_availability_zones = ["${var.region}a", "${var.region}c"]
  environment = terraform.workspace
  tag = "managed via Terraform"
}

module "network" {
  source                   = "./modules/network"
  environment              = local.environment
  vpc_cidr                 = var.vpc_cidr
  public_subnets_cidr      = var.public_subnets_cidr
  private_subnets_cidr     = var.private_subnets_cidr
  availability_zones       = local.environment == "development" ? local.development_availability_zones : local.production_availability_zones
}

module "s3" {
  source                                    = "./modules/s3-bucket"
  environment                               = local.environment
  politicia_media_cors_allowed_origins      = var.politicia_media_cors_allowed_origins
  politicia_thumbnail_cors_allowed_origins  = var.politicia_thumbnail_cors_allowed_origins
}

module "cloudfront" {
  source = "./modules/cloudfront"
  environment = local.environment
  politicia_media_bucket_id = module.s3.politicia_media_bucket_id
  politicia_media_bucket_domain_name = module.s3.politicia_media_bucket_domain_name
  politicia_thumbnail_bucket_id = module.s3.politicia_thumbnail_bucket_id
  politicia_thumbnail_bucket_domain_name = module.s3.politicia_thumbnail_bucket_domain_name
  public_allowed_http_methods = var.cloudfront_public_allowed_http_methods
  public_cached_http_methods = var.cloudfront_public_cached_http_methods
  cloudfront_restriction_type = var.cloudfront_restriction_type
  cloudfront_restriction_countries = var.cloudfront_restriction_countries
}