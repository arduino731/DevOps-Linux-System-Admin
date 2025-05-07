#!/bin/bash
set -e

# Sync code to EC2
rsync -avz --exclude 'node_modules' --exclude 'aws' -e "ssh -i ~/.ssh/fresh_key.pem" ./ ubuntu@ec2-3-86-244-173.compute-1.amazonaws.com:/home/ubuntu/app/DevOps-Linux-System-Admin

# SSH and deploy
ssh -i ~/.ssh/fresh_key.pem ubuntu@ec2-3-86-244-173.compute-1.amazonaws.com << 'EOF'
cd /home/ubuntu/app/DevOps-Linux-System-Admin
docker-compose down
docker-compose up -d --build
EOF
