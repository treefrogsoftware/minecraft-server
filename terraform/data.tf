data "aws_availability_zones" "az_list" {}

data "aws_caller_identity" "caller_id" {}

data "aws_subnet_ids" "minecraft_subnet_ids" {
  vpc_id     = aws_vpc.minecraft_vpc.id
  depends_on = [aws_subnet.minecraft_subnets]
}

data "aws_iam_policy_document" "minecraft_server_policy_document" {
  statement {
    sid = "1"
    actions = [
      "s3:PutAnalyticsConfiguration",
      "s3:GetObjectVersionTagging",
      "s3:CreateBucket",
      "s3:ReplicateObject",
      "s3:GetBucketObjectLockConfiguration",
      "s3:GetObjectAcl",
      "s3:PutLifecycleConfiguration",
      "s3:GetObjectVersionAcl",
      "s3:DeleteObject",
      "s3:GetBucketPolicyStatus",
      "s3:GetObjectRetention",
      "s3:GetBucketWebsite",
      "s3:PutReplicationConfiguration",
      "s3:PutObjectLegalHold",
      "s3:GetBucketNotification",
      "s3:GetObjectLegalHold",
      "s3:PutBucketCORS",
      "s3:GetReplicationConfiguration",
      "s3:ListMultipartUploadParts",
      "s3:GetObject",
      "s3:PutBucketNotification",
      "s3:PutObject",
      "s3:PutBucketLogging",
      "s3:GetAnalyticsConfiguration",
      "s3:GetObjectVersionForReplication",
      "s3:PutBucketObjectLockConfiguration",
      "s3:CreateAccessPoint",
      "s3:GetLifecycleConfiguration",
      "s3:GetBucketTagging",
      "s3:DeleteObjectVersion",
      "s3:GetBucketLogging",
      "s3:ListBucketVersions",
      "s3:RestoreObject",
      "s3:ListBucket",
      "s3:GetBucketPolicy",
      "s3:PutEncryptionConfiguration",
      "s3:GetEncryptionConfiguration",
      "s3:GetObjectVersionTorrent",
      "s3:AbortMultipartUpload",
      "s3:GetBucketRequestPayment",
      "s3:GetAccessPointPolicyStatus",
      "s3:UpdateJobPriority",
      "s3:GetObjectTagging",
      "s3:GetMetricsConfiguration",
      "s3:PutBucketVersioning",
      "s3:GetBucketPublicAccessBlock",
      "s3:ListBucketMultipartUploads",
      "s3:PutMetricsConfiguration",
      "s3:GetBucketVersioning",
      "s3:GetBucketAcl",
      "s3:PutInventoryConfiguration",
      "s3:GetObjectTorrent",
      "s3:PutObjectRetention",
      "s3:GetBucketCORS",
      "s3:GetAccessPointPolicy",
      "s3:GetBucketLocation",
      "s3:GetObjectVersion",
    ]

    resources = [
      join("", ["arn:aws:s3:::", var.backup_bucket_name]),
    ]
  }
}