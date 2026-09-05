# Provider AWS

terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
    region = var.aws_region
}

# Obter a AMI mais recente do Amazon Linux 2023
data "aws_ami" "amazon_linux" {
    most_recent = true

    filter {
        name   = "name"
        values = ["al2023-ami-*-x86_64"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["amazon"]
}

# Key Pair para SSH
resource "aws_key_pair" "devops_key" {
    key_name   = var.key_name
    public_key = file("~/.ssh/devops-key.pub")
}

# Security Group
resource "aws_security_group" "devops_sg" {
    name = "devops-lab-sg"
    description = "Security group for DevOps lab (SSH + HTTP)"

    # Regra SSH (Porta 22) -  aberto para deploy via GitHub Actions
    ingress {
        description = "SSH"
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Regra HTTP (Porta 80) - Acesso publico para a aplicação
    ingress {
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Regra de saida - Permitir todo o trafego de saida
    egress {
        from_port = 0
        to_port   = 0
        protocol  = "-1" #Significa todos os protocolos
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "devops-lab-sg"
    }
}

# Instancia EC2
resource "aws_instance" "devops_lab" {
    ami                     = data.aws_ami.amazon_linux.id
    instance_type           = var.instance_type
    key_name                = aws_key_pair.devops_key.key_name
    vpc_security_group_ids  = [aws_security_group.devops_sg.id]
    user_data               = file("user_data.sh")

    tags = {
        Name = "devops-lab"
    }
}