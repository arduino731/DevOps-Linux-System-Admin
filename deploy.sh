#!/bin/bash

# ========================
# 🔁 Deployment Script
# ========================
KEY_PATH="$HOME/.ssh/ssh1.pem"
REMOTE_USER="ubuntu"
REMOTE_HOST="ec2-34-229-129-246.compute-1.amazonaws.com"
REMOTE_DIR="~/app"

echo "🚀 Starting deployment to $REMOTE_HOST"

# Step 1: Sync files
rsync -avz --exclude 'node_modules' --exclude '.git' --exclude '.env' \
-e "ssh -i $KEY_PATH" \
. $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR

# Step 2: SSH into server and run app
echo "✅ Code synced. Logging into EC2..."
ssh -i $KEY_PATH $REMOTE_USER@$REMOTE_HOST << 'EOF'
  cd ~/app
  echo "📦 Installing dependencies..."
  npm install
  echo "🚀 Starting server..."
  npm start
EOF
