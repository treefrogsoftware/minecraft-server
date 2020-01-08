# Creates the VPC and all basic network infra required for server.

resource "aws_vpc" "minecraft_vpc" {
  cidr_block = var.minecraft_vpc_cidr
  tags = {
    Name = "Minecraft VPC"
  }
}

resource "aws_internet_gateway" "minecraft_igw" {
  vpc_id = aws_vpc.minecraft_vpc.id
  tags = {
    Name = "Minecraft VPC IGW"
  }
}

resource "aws_route_table" "minecraft_route_table" {
  vpc_id = aws_vpc.minecraft_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.minecraft_igw.id
  }
  tags = {
    Name = "Minecraft VPC route table"
  }
}

resource "aws_subnet" "minecraft_subnets" {
  map_public_ip_on_launch = true

  tags = {
    Name = join(" ", ["Minecraft Subnet for", data.aws_availability_zones.az_list.names[count.index]])
  }

  count             = length(data.aws_availability_zones.az_list.names)
  cidr_block        = cidrsubnet(var.minecraft_vpc_cidr, 2, count.index)
  vpc_id            = aws_vpc.minecraft_vpc.id
  availability_zone = data.aws_availability_zones.az_list.names[count.index]
}

resource "aws_route_table_association" "minecraft_server_associations" {
  count          = length(data.aws_availability_zones.az_list.names)
  route_table_id = aws_route_table.minecraft_route_table.id
  subnet_id      = sort(data.aws_subnet_ids.minecraft_subnet_ids.ids)[count.index]
}
