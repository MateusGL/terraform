variable "db_subnet_group_name" {
  description = "Nome do grupo de sub-redes da RDS"
  type        = string
}

variable "rds_sg_id" {
  description = "ID do grupo de segurança da RDS"
  type        = string
}

variable "identifier" {
  description = "The name to assign to the instance identifier"
  type        = string
  default     = "postgress"
}


variable "username" {
  description = "username for the db instance"
  type        = string
}

variable "password" {
  description = "password for the db instance"
  type        = string
}

variable "stage" {
  description = "The deployment stage (dev, hmo, prod)"
  type        = string
}