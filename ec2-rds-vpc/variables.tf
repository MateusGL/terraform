variable "db_subnet_group_name" {
  description = "name for the db subnet group"
  type        = string
}

variable "stage" {
  description = "The deployment stage (dev, hmo, prod)"
  type        = string
}

variable "region" {
  description = "The AWS Region to Deploy"
  type        = string
  default     = "us-east-1"
}

variable "availability_zone" {
  description = "The AWS availability Zone to Deploy"
  type        = string
  default     = "us-east-1a"
}

variable "rds_db_username" {
  description = "username for the db instance"
  type        = string
}

variable "rds_db_password" {
  description = "password for the db instance"
  type        = string
}