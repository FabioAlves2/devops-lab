output "instance_public_ip" {
    description = "IP de rede publica da instancia EC2"
    value       = aws_instance.devops_lab.public_ip
}

output "ssh_command" {
    description = "Comando para conectar via SSH"
    value       = "ssh -i ~/.ssh/devops-key ec2-user@${aws_instance.devops_lab.public_ip}"
}

output "app_url" {
    description = "URL da aplicação"
    value       = "http://${aws_instance.devops_lab.public_ip}"
}
