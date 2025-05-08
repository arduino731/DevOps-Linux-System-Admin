#!/bin/bash

echo "[$(date)] Starting deployment..."

set -e

# Optional: Check for unhealthy containers locally (on your machine)
# You probably meant to do this on EC2 after deploy, not locally
# So this line is not useful here and should be removed or moved inside the SSH block

# Sync code to EC2 (if not using Git-based deployment)
# rsync -avz --exclude 'node_modules' --exclude 'aws' -e "ssh -i ~/.ssh/fresh_key.pem" ./ ubuntu@ec2-3-86-244-173.compute-1.amazonaws.com:/home/ubuntu/app/DevOps-Linux-System-Admin

# SSH into EC2 and deploy
ssh -i ~/.ssh/fresh_key.pem ubuntu@ec2-3-86-244-173.compute-1.amazonaws.com << 'EOF'
  echo "[$(date)] Pulling latest code and restarting containers..."

  cd ~/app/DevOps-Linux-System-Admin
  git pull origin main

  docker-compose down
  docker-compose up -d --build

  echo "[$(date)] Deployment complete."

  # Check for any unhealthy containers
  docker ps --filter "health=unhealthy" --format "⚠️  Unhealthy container: {{.Names}}"
EOF
