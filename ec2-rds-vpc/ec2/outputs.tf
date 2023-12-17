output "ec2_sg_id" {
  value       = aws_security_group.ec2_sg.id
  description = "The ID of the EC2 security group"
}

output "ec2_geth_key" {
  value       = tls_private_key.geth_node_key.private_key_pem
  description = "The private key of geth ec2 node to acess it from ssh"
}