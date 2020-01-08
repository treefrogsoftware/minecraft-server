output "az_list" {
  value = data.aws_availability_zones.az_list
}

output "subnets" {
  value = aws_subnet.minecraft_subnets
}