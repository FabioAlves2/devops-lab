variable "aws_region" {
    description = "Região da AWS"
    type        = string
    default     = "eu-west-1"
}

variable "instance_type" {
    description = "Tipo de instância EC2"
    type        = string
    default     = "t3.micro"
}

variable "key_name" {
    description = "Nome da chave de acesso SSH"  
    type        = string
    default     = "devops-key-tf"
}

variable "github_repo" {
    description = "URL do repositório GitHub"
    type        = string
    default     = "https://github.com/FabioAlves2/devops-lab.git"
}
