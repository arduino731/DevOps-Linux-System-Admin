#!/bin/bash

# Exit immediately on error
set -e

echo "🔄 Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "🐙 Installing Git..."
sudo apt install -y git

echo "🐳 Installing Docker..."
sudo apt install -y docker.io

echo "🧱 Installing Docker Compose..."
sudo apt install -y docker-compose

# echo "📁 Cloning your GitHub repo..."
# git clone https://github.com/arduino731/DevOps-Linux-System-Admin.git
# cd DevOps-Linux-System-Admin


echo "🚀 Building and running Docker containers..."
docker compose up -d --build

echo "✅ Setup complete! Frontend running on http://localhost:8080 and backend on http://localhost:5001"
