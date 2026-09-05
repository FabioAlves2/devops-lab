# devops-lab
training learnings on devops practices

## Infraestrutura (Terraform)
A infraestrutura esta definida em codigo na pasta `/infra`.
### Recursos criados:
- EC2 t3.micro (Amazon Linux 2023)
- Security Group (portas 22 e 80)
- Key Pair SSH
### Como usar:
```bash
cd infra
terraform init # inicializa (so na 1a vez)
terraform plan # mostra o que vai criar
terraform apply # cria tudo
terraform destroy # apaga tudo
```