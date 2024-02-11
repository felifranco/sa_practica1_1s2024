terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_security_group" "nginx" {
  name   = "nginx_access"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 81
    to_port     = 81
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "access_key" {
  key_name   = "access_key"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "nginx" {
  ami                         = "ami-0c7217cdde317cfec" # Ubuntu Server 22.04 LTS (HVM), SSD Volume Type
  instance_type               = "t2.micro"              # 1 vCPU 1 GiB Memoria
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.nginx.id]
  key_name                    = aws_key_pair.access_key.key_name

  provisioner "file" {
    source      = "../react-vite-sa-pra1/dist/"
    destination = "/home/ubuntu"

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.private_key_path)
      host        = aws_instance.nginx.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /var/www/sa_practica1"
    ]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.private_key_path)
      host        = aws_instance.nginx.public_ip
    }
  }
}

resource "aws_instance" "ansible" {
  ami                         = "ami-0c7217cdde317cfec" # Ubuntu Server 22.04 LTS (HVM), SSD Volume Type
  instance_type               = "t2.micro"              # 1 vCPU 1 GiB Memoria
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.nginx.id]
  key_name                    = aws_key_pair.access_key.key_name

  provisioner "file" {
    source      = "../ansible/"
    destination = "/home/ubuntu"

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.private_key_path)
      host        = aws_instance.ansible.public_ip
    }
  }

  provisioner "file" {
    source      = "./ssh/key_pair"
    destination = "/home/ubuntu/key_pair"

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.private_key_path)
      host        = aws_instance.ansible.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install software-properties-common -y",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt install ansible -y",
      "cd /home/ubuntu",
      "echo nginx_ec2 ansible_host=${aws_instance.nginx.public_ip} ansible_connection=ssh ansible_user=${var.ssh_user} >> hosts",
      "chmod 400 key_pair",
      "ansible-playbook --private-key key_pair nginx_from_ec2.yml -i hosts"
    ]

    connection {
      type        = "ssh"
      user        = var.ssh_user
      private_key = file(var.private_key_path)
      host        = aws_instance.ansible.public_ip
    }
  }
}

