provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    region = "eu-west-1"
    bucket = "westys.net.tfstate"
    key    = "production/minecraft-server.tfstate"
  }
}
