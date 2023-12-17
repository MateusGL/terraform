variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "ami_id" {
  description = "The ID of the AMI to use"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to associate with the instance"
  type        = string
}

variable "instance_name" {
  description = "The name to assign to the instance"
  type        = string
  default     = "MyEC2Instance"
}

variable "availability_zone" {
  description = "The AWS availability Zone to Deploy"
  type        = string
}