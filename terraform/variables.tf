variable "minecraft_vpc_cidr" {
  description = "VPC CIDR Block to allocate minecraft server VPC."
  type        = string
  default     = "172.17.1.0/26"
}

variable "ec2_instance_type" {
  description = "The size of EC2 instance to put in the launch template"
  type        = string
  default     = "t3.medium"
}

variable "ami_id" {
  description = "Choose your poison (ubuntu|debian|redhat|centos) etc."
  type        = string
  default     = "ami-02df9ea15c1778c9c"
}

variable "backup_bucket_name" {
  description = "The DNS (name) for the backup bucket"
  type        = string
  default     = "westys-minecraft-backup-bucket"
}

variable "public_key" {
  description = "Public part of an SSH key pair for uploading to AWS."
  type        = string
  default     = "~/.ssh/minecraft.pub"
}

variable "ssh_ips" {
  description = "IP addresses to allow port 22 inbound from (must be supplied via commandline)."
  type        = list
}

