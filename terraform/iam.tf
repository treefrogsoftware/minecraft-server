resource "aws_iam_instance_profile" "minecraft_server_instance_profile" {
  name = "minecraft_server_instance_profile"
  role = aws_iam_role.minecraft_server_role.name
}

resource "aws_iam_role" "minecraft_server_role" {
  name               = "minecraft-server-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "minecraft_server_policy" {
  name   = "minecraft-server-policy"
  policy = data.aws_iam_policy_document.minecraft_server_policy_document.json
}

resource "aws_iam_role_policy_attachment" "minecraft_rp_attachment" {
  policy_arn = aws_iam_policy.minecraft_server_policy.arn
  role       = aws_iam_role.minecraft_server_role.name
}
