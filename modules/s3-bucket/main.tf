resource "aws_s3_bucket" "politicia_media" {
  bucket = "${var.environment}-politicia-media"
  acl    = "private"

  tags = {
    Environment = var.environment
  }
}

resource "aws_s3_bucket_object" "media_image_dir" {
  bucket = aws_s3_bucket.politicia_media.id
  key    = "IMAGE/"
}

resource "aws_s3_bucket_object" "media_video_dir" {
  bucket = aws_s3_bucket.politicia_media.id
  key    = "VIDEO/"
}

resource "aws_s3_bucket_object" "media_profile_image_dir" {
  bucket = aws_s3_bucket.politicia_media.id
  key    = "PROFILE_PIC/"
}

resource "aws_s3_bucket_versioning" "politicia_media_versioning" {
  bucket = aws_s3_bucket.politicia_media.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_cors_configuration" "politicia_media_cors" {
  bucket = aws_s3_bucket.politicia_media.id
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = var.politicia_media_cors_allowed_origins
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

resource "aws_s3_bucket" "politicia_thumbnail" {
  bucket = "${var.environment}-politicia-thumbnail"
  acl    = "private"

  tags = {
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "politicia_thumbnail_versioning" {
  bucket = aws_s3_bucket.politicia_thumbnail.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_cors_configuration" "politicia_thumbnail_cors" {
  bucket = aws_s3_bucket.politicia_thumbnail.id
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = var.politicia_thumbnail_cors_allowed_origins
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}