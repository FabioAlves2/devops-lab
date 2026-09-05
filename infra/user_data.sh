#!/bin/bash
set -e

#Atualiza o sistema
yum update -y

#Instala python, pip e git
yum install python3 python3-pip git -y

#Clona o repositorio do Github
cd /home/ec2-user
git clone https://github.com/FabioAlves2/devops-lab.git
cd devops-lab

#Instala dependencias
pip3 install flask

#Cria o script de deploy automatico para o GitHub Actions
cat << 'DEPLOY' > /home/ec2-user/deploy.sh
#!/bin/bash
echo "=== Inicio do deploy ==="
cd /home/ec2-user/devops-lab
git pull origin main
pip3 install -r requirements.txt
sudo pkill -f "python3 app.py" || true
sleep 2
sudo nohup python3 app.py > /tmp/app.log 2>&1 &
echo "=== Deploy completo ==="
DEPLOY
chmod +x /home/ec2-user/deploy.sh

# Ajusta permissoes
chown -R ec2-user:ec2-user /home/ec2-user/devops-lab
chown ec2-user:ec2-user /home/ec2-user/deploy.sh

# Lanca a app
nohup python3 app.py > /tmp/app.log 2>&1 &
