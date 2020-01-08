resource "aws_security_group" "minecraft_sg" {
  vpc_id = aws_vpc.minecraft_vpc.id

  tags = {
    Name = "Minecraft Server security group"
  }
}

resource "aws_security_group_rule" "allow_25565_inbound_from_all" {
  from_port         = 25565
  protocol          = "TCP"
  security_group_id = aws_security_group.minecraft_sg.id
  to_port           = 25565
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_22_from_defined_ips" {
  from_port         = 22
  protocol          = "TCP"
  security_group_id = aws_security_group.minecraft_sg.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = var.ssh_ips
}

resource "aws_security_group_rule" "allow_all_outbound" {
  from_port         = 0
  protocol          = -1
  security_group_id = aws_security_group.minecraft_sg.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_autoscaling_group" "minecraft_asg" {
  max_size             = 1
  min_size             = 1
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.minecraft_asg_launch_config.name
  vpc_zone_identifier  = data.aws_subnet_ids.minecraft_subnet_ids.ids

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "Minecraft-Server"
  }
}


resource "aws_launch_configuration" "minecraft_asg_launch_config" {
  iam_instance_profile        = aws_iam_instance_profile.minecraft_server_instance_profile.name
  associate_public_ip_address = true
  security_groups             = [aws_security_group.minecraft_sg.id]
  image_id                    = var.ami_id
  instance_type               = var.ec2_instance_type
  key_name                    = aws_key_pair.minecraft_key.key_name
  name                        = "minecraft-launch-config"
  user_data                   = base64encode(file("bootstrap.sh"))
}

resource "aws_key_pair" "minecraft_key" {
  public_key = file(var.public_key)
  key_name   = "minecraft-server-key"
}
