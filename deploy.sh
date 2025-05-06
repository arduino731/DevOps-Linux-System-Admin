#!/bin/bash

# Define variables
SERVER="ubuntu@ec2-13-218-60-167.compute-1.amazonaws.com"
KEY_PATH="$HOME/.ssh/fresh-key.pem"
REMOTE_DIR="/home/ubuntu/app"

# Upload current folder contents to EC2
echo "Uploading project to EC2..."
rsync -avz -e "ssh -i $KEY_PATH" --exclude 'node_modules' ./ "$SERVER:$REMOTE_DIR"

# SSH and deploy
echo "Deploying on EC2..."
ssh -i "$KEY_PATH" "$SERVER" << EOF
  cd "$REMOTE_DIR" || exit 1
  docker-compose pull
  docker-compose down --remove-orphans
  docker-compose up -d --build
EOF
