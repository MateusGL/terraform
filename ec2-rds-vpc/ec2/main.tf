resource "aws_instance" "exchange_ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.subnet_id

  tags = {
    Name = var.instance_name
  }
}
# 
resource "tls_private_key" "geth_node_key" {
  algorithm = "RSA"
  rsa_bits  = 4096

  # resource "local_file" "geth_node_key_pem" {
  #   content         = tls_private_key.geth_node_key.private_key_pem
  #   filename        = "${path.module}/geth_node_key.pem"
  #   file_permission = "0400"
  # }
}

resource "aws_key_pair" "geth_key" {
  key_name   = "geth_key"
  public_key = tls_private_key.geth_node_key.public_key_openssh
  # public_key = file("~/.ssh/terraform.pub")
}

resource "aws_instance" "geth_node" {
  ami                    = var.ami_id
  instance_type          = "t2.micro" 
  key_name               = aws_key_pair.geth_key.key_name
  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.subnet_id

  tags = {
    Name = "geth_node"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo add-apt-repository -y ppa:ethereum/ethereum",
      "sudo apt-get update",
      "sudo apt-get install ethereum -y",
      "mkdir -p dev-node/private",
    ]

    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = tls_private_key.geth_node_key.private_key_pem
      # private_key = file("geth_node_key.pem")
      # private_key = file("~/.ssh/terraform")
    }
  }

}

resource "aws_ebs_volume" "geth_node_volume" {
  availability_zone = var.availability_zone
  size              = 50
  type              = "gp2"

  tags = {
    Name = "geth_node_storage"
  }
}

resource "aws_volume_attachment" "geth_node_volume_attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.geth_node_volume.id
  instance_id = aws_instance.geth_node.id
}
