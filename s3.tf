resource "random_uuid" "bucket_uuid" {}

resource "aws_s3_bucket" "my_bucket" {
  bucket        = random_uuid.bucket_uuid.result
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "s3" {
  bucket = aws_s3_bucket.my_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "s3" {
  depends_on = [aws_s3_bucket_ownership_controls.s3]
  bucket     = aws_s3_bucket.my_bucket.id
  acl        = "private"
}

resource "aws_s3_bucket_lifecycle_configuration" "s3" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    id     = "TransitionToIA"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}