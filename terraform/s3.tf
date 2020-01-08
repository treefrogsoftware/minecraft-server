resource "aws_s3_bucket" "minecraft_backup_bucket" {
  bucket = var.backup_bucket_name

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle {
    prevent_destroy = false
  }

  lifecycle_rule {
    id      = "backup_cleaning"
    enabled = true

    prefix = "minecraft/backups/"

    tags = {
      "rule"      = "backup_cleaning"
      "autoclean" = "true"
    }

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      days          = 60
      storage_class = "GLACIER"
    }

    noncurrent_version_expiration {
      days = 90
    }
  }
}

resource "aws_s3_bucket_policy" "only_allow_access_from_minecraft_vpc" {
  bucket = aws_s3_bucket.minecraft_backup_bucket.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "MYBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "IPAllow",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::${var.backup_bucket_name}/*",
      "Condition": {
         "IpAddress": {"aws:SourceIp": "${var.minecraft_vpc_cidr}"}
      }
    }
  ]
}
POLICY
}
