provider "aws" {
  region = "us-east-1"
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = tls_private_key.example.public_key_openssh
}

resource "local_file" "tf_key" {
  content  = tls_private_key.example.private_key_pem
  filename = "tf_key" #var.file_name
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.example.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Run http server"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc" "example" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "ExampleVPC"
  }
}

resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.example.id
}

resource "aws_route" "example" {
  route_table_id         = aws_route_table.example.id
  destination_cidr_block = "0.0.0.0/0" # Rota para a Internet
  gateway_id             = aws_internet_gateway.example.id
}

resource "aws_subnet" "example" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "ExampleSubnet"
  }
}

resource "aws_route_table_association" "example" {
  subnet_id      = aws_subnet.example.id
  route_table_id = aws_route_table.example.id
}

resource "aws_instance" "example_instance" {
  # Amazon Linux 2023 AMI
  ami                    = "ami-0230bd60aa48260c6"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  subnet_id              = aws_subnet.example.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  associate_public_ip_address = true


  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo apt-get update",
  #     "sudo apt-get install -y nginx"
  #   ]

  #   connection {
  #     type        = "ssh"
  #     user        = "ec2-user"
  #     private_key = tls_private_key.example.private_key_pem
  #     host        = self.public_ip
  #   }
  # }
  # depends_on = [aws_instance.example_instance]
}


