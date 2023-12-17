provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./vpc"
  // Inclua aqui quaisquer variáveis necessárias para o módulo VPC.
}

module "ec2" {
  source            = "./ec2"
  vpc_id            = module.vpc.vpc_id
  availability_zone = var.availability_zone

  # Amazon Linux 2023 AMI
  ami_id        = "ami-0230bd60aa48260c6"
  instance_type = "t2.micro"
  # 
  key_name          = "tf-keypar"
  security_group_id = module.ec2.ec2_sg_id
  subnet_id         = module.vpc.subnet_id
  instance_name     = "exchange-${var.stage}"
  // Inclua aqui quaisquer variáveis necessárias para o módulo EC2.
}

# module "rds" {
#   source               = "./rds"
#   db_subnet_group_name = module.vpc.db_subnet_group_name
#   rds_sg_id            = module.ec2.ec2_sg_id
#   identifier           = "exchange-postgress-${var.stage}"
#   username             = var.rds_db_username
#   password             = var.rds_db_password
#   stage                = var.stage
#   // Inclua aqui quaisquer variáveis necessárias para o módulo RDS.
# }
