output "instance_public_ip" {
  value = aws_instance.example_instance.public_ip
}

output "private_key" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}
