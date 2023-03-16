output "politicia_media_bucket_id" {
    value = aws_s3_bucket.politicia_media.id
}

output "politicia_thumbnail_bucket_id" {
    value = aws_s3_bucket.politicia_thumbnail.id
}

output "politicia_media_bucket_domain_name" {
    value = aws_s3_bucket.politicia_media.bucket_domain_name
}

output "politicia_thumbnail_bucket_domain_name" {
    value = aws_s3_bucket.politicia_thumbnail.bucket_domain_name
}