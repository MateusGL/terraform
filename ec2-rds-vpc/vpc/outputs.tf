output "vpc_id" {
 value = aws_vpc.main.id
 description = "The ID of the VPC"
}

output "db_subnet_group_name" {
 value = aws_db_subnet_group.my_db_subnet_group.name
 description = "The name of the DB subnet group"
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.public.id
}
