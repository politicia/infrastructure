resource "aws_s3_bucket" "media" {
  bucket = var.media_bucket_name
  acl    = "private"

  tags = {
    Environment = var.environment
  }
}
resource "aws_s3_bucket" "thumbnail" {
  bucket = var.thumbnail_bucket_name
  acl    = "private"

  tags = {
    Environment = var.environment
  }
}
resource "aws_s3_bucket" "profile_pics" {
  bucket = var.profile_pics_bucket_name

  tags = {
    Environment = var.environment
  }
}

