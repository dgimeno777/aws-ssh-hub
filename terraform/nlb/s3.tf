resource "aws_s3_bucket" "hub" {
  bucket        = "ssh-hub-${local.resource_name_suffix}"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.hub.id
  acl    = "private"
}

data "aws_kms_key" "aws_s3" {
  key_id = "alias/aws/s3"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "hub" {
  bucket = aws_s3_bucket.hub.bucket
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = data.aws_kms_key.aws_s3.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
