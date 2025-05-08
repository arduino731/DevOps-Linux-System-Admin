#!/bin/bash

echo "[$(date)] Starting deployment..."
set -e

# ✅ Sync code to EC2 (excluding large/unnecessary files)
rsync -avz --exclude 'node_modules' --exclude 'aws' \
  -e "ssh -i ~/.ssh/fresh_key.pem" \
  ./ ubuntu@ec2-3-86-244-173.compute-1.amazonaws.com:/home/ubuntu/app/DevOps-Linux-System-Admin

# ✅ SSH into EC2 to deploy app and install monitor.sh
ssh -i ~/.ssh/fresh_key.pem ubuntu@ec2-3-86-244-173.compute-1.amazonaws.com << 'EOF'
  echo "[$(date)] Restarting Docker containers..."
  cd ~/app/DevOps-Linux-System-Admin
  docker-compose down
  docker-compose up -d --build

  echo "[$(date)] Installing monitoring script..."
  sudo cp monitoring/monitor.sh /etc/cron.daily/monitor.sh
  sudo chmod +x /etc/cron.daily/monitor.sh

  echo "[$(date)] Cleaning up Docker system..."
  docker system prune -f

  echo "[$(date)] Checking for unhealthy containers..."
  docker ps --filter "health=unhealthy" --format "⚠️  Unhealthy container: {{.Names}}"

  echo "[$(date)] Deployment complete."
EOF
